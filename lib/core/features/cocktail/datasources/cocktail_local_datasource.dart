import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';

abstract class CocktailLocalDatasource {
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
        query = 'WHERE strCategory = $category';
      } else if (alcoholic != null) {
        query = 'WHERE strAlcoholic = $alcoholic';
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
}
