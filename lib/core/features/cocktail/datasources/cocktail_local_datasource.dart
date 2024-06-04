import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/db/scripts/cocktails_table.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class CocktailLocalDatasource {
  Future<Cocktail> lookupRandom();
  Future<Cocktail> getDetails(String id);
  Future<int> save(Cocktail cocktail);
  Future<List<CocktailItem>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  });
}

class CocktailLocalDatasourceImpl extends CocktailLocalDatasource {
  final Db db;

  CocktailLocalDatasourceImpl({required this.db});

  @override
  Future<List<CocktailItem>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  }) async {
    try {
      String query;
      if (ingredient != null) {
        query = 'LOWER(strIngredient1) LIKE LOWER(\'%$ingredient%\')';
      } else if (category != null) {
        query = 'LOWER(strCategory) = LOWER($category)';
      } else if (alcoholic != null) {
        query = 'LOWER(strAlcoholic) = LOWER($alcoholic)';
      } else {
        throw DatasourceError(message: 'Oops, you need to specify a filter!');
      }

      final database = await db.get();
      final List result = await database.query(
        'cocktails',
        where: query,
        columns: [
          'idDrink',
          'strDrink',
          'strDrinkThumb',
        ],
      );

      return result.map((e) => CocktailItem.fromMap(e)).toList();
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
  Future<Cocktail> getDetails(String id) async {
    try {
      final database = await db.get();
      final result = await database.query(
        'cocktails',
        columns: cocktailsColumns,
        where: 'idDrink = ?',
        whereArgs: [id],
      );
      if (result.isEmpty) {
        throw DatasourceError(message: 'Cocktail not in the database!');
      }
      return Cocktail.fromMap(result.first);
    } catch (e) {
      throw DatasourceError(
          metadata: e.toString(),
          message: 'Sorry, something went wrong search the cocktail :/');
    }
  }

  @override
  Future<int> save(Cocktail cocktail) async {
    try {
      final database = await db.get();
      final result = await database.insert(
        'cocktails',
        cocktail.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return result;
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
  Future<Cocktail> lookupRandom() async {
    try {
      final database = await db.get();
      final List result = await database.query(
        'cocktails',
        columns: cocktailsColumns,
        orderBy: 'RANDOM()',
        limit: 1,
      );
      if (result.isEmpty) {
        throw DatasourceError(
            message: 'Looks like you don\'t have any cocktails saved');
      }

      return Cocktail.fromMap(result.first);
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(metadata: e.toString());
    }
  }
}
