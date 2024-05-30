import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/db/scripts/cocktails_v2_table.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:sqflite/sqflite.dart';

abstract class CocktailV2LocalDatasource {
  Future<CocktailV2> lookupRandom();
  Future<int> save(List<CocktailV2> cocktails);
  Future<List<CocktailV2>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  });
}

class CocktailV2LocalDatasourceImpl implements CocktailV2LocalDatasource {
  final Db db;

  CocktailV2LocalDatasourceImpl({required this.db});

  @override
  Future<List<CocktailV2>> getCocktails({
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
            select distinct ME.cocktail_id,
            from measures ME
            left join ingredients IN on ME.ingredient_id = IN.id
            where IN.name like '%$ingredient%';
          """);
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
              IN.id as ingredient_id,
              IN.name as ingredient_name
            from measures ME
            left join ingredients IN on ME.ingredient_id = IN.id
            where ME.cocktail_id = '${cocktailJson['id']}';
          """);

          return CocktailV2.fromJson({
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
  Future<CocktailV2> lookupRandom() async {
    // TODO: implement lookupRandom
    throw UnimplementedError();
  }

  @override
  Future<int> save(List<CocktailV2> cocktails) async {
    // TODO: implement save
    throw UnimplementedError();
  }
}
