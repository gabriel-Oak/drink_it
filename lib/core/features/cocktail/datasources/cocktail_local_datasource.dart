import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/db/scripts/cocktails_table.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class CocktailLocalDatasource {
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
        query = 'WHERE LOWER(strIngredient1) LIKE LOWER(\'%$ingredient%\')';
      } else if (category != null) {
        query = 'WHERE LOWER(strCategory) = LOWER($category)';
      } else if (alcoholic != null) {
        query = 'WHERE LOWER(strAlcoholic) = LOWER($alcoholic)';
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
        where: 'WHERE idDrink = ?',
        whereArgs: [id],
      );
      if (result.isEmpty) throw DatasourceError();
      return Cocktail.fromMap(result.first);
    } catch (e) {
      throw DatasourceError(
          metadata: e.toString(),
          message:
              'Sorry, something went wrong saving the cocktail locally :/');
    }
  }

  @override
  Future<int> save(Cocktail cocktail) async {
    try {
      final database = await db.get();
      final result = await database.insert(
        'cocktail',
        cocktail.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return result;
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(
          metadata: e.toString(),
          message: 'Sorry, it wasn\'t possible to find your cocktail :/');
    }
  }
}
