import 'dart:async';

import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/db/scripts/cocktails_table.dart';
import 'package:drink_it/core/db/scripts/cocktails_v2_table.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:sqflite/sqflite.dart';

abstract class CocktailV2LocalDatasource {
  Future<ShallowCocktail> lookupRandom();
  Future<int> save(List<CocktailV2> cocktails);
  Future<int> saveShallow(List<ShallowCocktail> cocktails);
  Future<List<ShallowCocktail>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  });
  Future<CocktailV2> getDetails(String cocktailId);
}

class CocktailV2LocalDatasourceImpl implements CocktailV2LocalDatasource {
  final Db db;

  CocktailV2LocalDatasourceImpl({required this.db});

  @override
  Future<List<ShallowCocktail>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  }) async {
    try {
      String query;
      Database? database;
      if (ingredient != null) {
        database = await db.get();
        final List cocktailsIds = await database.rawQuery("""
            select distinct ME.cocktail_id
            from measures ME
            left join ingredients IG on ME.ingredient_id = IG.id
            where lower(IG.name) like lower('%$ingredient%');
          """);

        final tttt = await database.query('ingredients');
        print(tttt);

        query =
            'id in (${cocktailsIds.map((e) => "'${e['cocktail_id']}'").join(', ')})';
      } else if (category != null) {
        query = 'lower(category) = lower($category)';
      } else if (alcoholic != null) {
        query = 'lower(alcoholic) = lower($alcoholic)';
      } else {
        throw CocktailInvalidSearchError();
      }

      database = database ?? await db.get();
      final List<Map<String, dynamic>> cocktailsResult = await database.query(
        'cocktails_v2',
        where: query,
        columns: cocktailsV2Columns,
      );

      final result = Future.wait(
        cocktailsResult.map((cocktailJson) async {
          final List measuresJson = await database!.rawQuery("""
            select 
              ME.measure,
              IG.id as ingredient_id,
              IG.name as ingredient_name
            from measures ME
            left join ingredients IG on ME.ingredient_id = IG.id
            where ME.cocktail_id = '${cocktailJson['id']}';
          """);

          return ShallowCocktail.fromJson({
            ...cocktailJson,
            'measures': measuresJson
                .map((e) => {
                      'measure': e['measure'],
                      'ingredient': {
                        'id': e['ingredient_id'],
                        'name': e['ingredient_name'],
                      }
                    })
                .toList()
          });
        }).toList(),
      );

      return result;
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(
          metadata: e.toString(),
          message:
              'Sorry, something wen wrong searching for your cocktails, stay sober :(');
    }
  }

  @override
  Future<ShallowCocktail> lookupRandom() async {
    try {
      final database = await db.get();
      final List cocktailsResult = await database.query(
        'cocktails_v2',
        columns: [
          "id",
          "name",
          "thumb",
          "category",
        ],
        orderBy: 'RANDOM()',
        limit: 1,
      );

      if (cocktailsResult.isEmpty) {
        throw NoCocktailsSavedError();
      }

      return await Future(() async {
        final List measuresJson = await database.rawQuery("""
            select 
              ME.measure,
              IG.id as ingredient_id,
              IG.name as ingredient_name
            from measures ME
            left join ingredients IG on ME.ingredient_id = IG.id
            where ME.cocktail_id = '${cocktailsResult.first['id']}';
          """);

        return ShallowCocktail.fromJson({
          ...cocktailsResult.first,
          'measures': measuresJson
              .map((e) => {
                    'measure': e['measure'],
                    'ingredient': {
                      'id': e['ingredient_id'],
                      'name': e['ingredient_name'],
                    }
                  })
              .toList()
        });
      });
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(metadata: e.toString());
    }
  }

  @override
  Future<int> save(List<CocktailV2> cocktails) async {
    try {
      final database = await db.get();
      final results = await Future.wait(cocktails.map(
        (cocktail) => database.transaction((transaction) async {
          final cocktailMap = cocktail.toJson();
          cocktailMap.remove('measures');
          final result = await transaction.insert(
            'cocktails_v2',
            cocktailMap,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          final test = await transaction
              .query('cocktails_v2', where: 'id = ?', whereArgs: [cocktail.id]);
          print(test);

          if (result > 0) {
            await transaction.delete(
              'measures',
              where: 'cocktail_id = ${cocktail.id}',
            );

            await Future.wait(cocktail.measures.map((measure) async {
              await transaction.insert(
                'ingredients',
                measure.ingredient.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              );

              await transaction.insert(
                'measures',
                {
                  'measure': measure.measure,
                  'cocktail_id': cocktail.id,
                  'ingredient_id': measure.ingredient.id,
                },
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }));
          }

          return result;
        }).catchError((_) => 0),
      ));

      return results.reduce((value, element) => value + element);
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(
        metadata: e.toString(),
        message: 'Sorry, it wasn\'t possible to find your cocktail :/',
      );
    }
  }

  @override
  Future<CocktailV2> getDetails(String cocktailId) async {
    try {
      final database = await db.get();
      final List cocktailResult = await database.query(
        'cocktails_v2',
        columns: cocktailsV2Columns,
        limit: 1,
        where: 'id = ?',
        whereArgs: [cocktailId],
      );
      final Map<String, dynamic>? cocktail = cocktailResult.first;

      if (cocktailResult.isEmpty || cocktail?['instructions'] == null) {
        throw NoCocktailsSavedError();
      }

      final List measuresJson = await database.rawQuery("""
        select 
          ME.measure,
          IG.id as ingredient_id,
          IG.name as ingredient_name
        from measures ME
        left join ingredients IG on ME.ingredient_id = IG.id
        where ME.cocktail_id = '${cocktail!['id']}';
      """);

      return CocktailV2.fromJson({
        ...cocktail,
        'measures': measuresJson
            .map((e) => {
                  'measure': e['measure'],
                  'ingredient': {
                    'id': e['ingredient_id'],
                    'name': e['ingredient_name'],
                  }
                })
            .toList()
      });
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(
        metadata: e.toString(),
        message: 'Sorry, it wasn\'t possible to find your cocktail :/',
      );
    }
  }

  @override
  Future<int> saveShallow(List<ShallowCocktail> cocktails) async {
    try {
      final database = await db.get();
      final results = await Future.wait(cocktails.map(
        (cocktail) => database.transaction((transaction) async {
          final cocktailMap = cocktail.toJson();
          cocktailMap.remove('measures');
          final result = await transaction.insert(
            'cocktails_v2',
            cocktailMap,
            conflictAlgorithm: ConflictAlgorithm.ignore,
          );

          if (result > 0) {
            await transaction.delete(
              'measures',
              where: 'cocktail_id = ${cocktail.id}',
            );

            await Future.wait(cocktail.measures.map((measure) async {
              await transaction.insert(
                'ingredients',
                measure.ingredient.toJson(),
                conflictAlgorithm: ConflictAlgorithm.ignore,
              );

              await transaction.insert(
                'measures',
                {
                  'measure': measure.measure,
                  'cocktail_id': cocktail.id,
                  'ingredient_id': measure.ingredient.id,
                },
                conflictAlgorithm: ConflictAlgorithm.ignore,
              );
            })).catchError(print);
          }

          return result;
        }).catchError(print),
      ));

      return results.reduce((value, element) => value + element);
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(
        metadata: e.toString(),
        message: 'Sorry, it wasn\'t possible to find your cocktail :/',
      );
    }
  }
}
