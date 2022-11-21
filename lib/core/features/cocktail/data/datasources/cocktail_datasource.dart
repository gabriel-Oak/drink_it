import 'package:dio/dio.dart';
import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/data/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/domain/cocktail_errors.dart';
import 'package:drink_it/core/utils/network_info.dart';

abstract class CocktailDatasource {
  Future<List<CocktailItemModel>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  });
}

class CocktailDatasourceImpl extends CocktailDatasource {
  final Dio client;
  final NetworkInfo network;
  final Db db;

  CocktailDatasourceImpl({
    required this.client,
    required this.network,
    required this.db,
  });

  @override
  Future<List<CocktailItemModel>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  }) async {
    try {
      final Map<String, String> queryParameter = {};
      String query;
      if (ingredient != null) {
        queryParameter['i'] = ingredient;
        query = 'WHERE LOWER(strIngredient1) LIKE LOWER(\'%$ingredient%\')';
      } else if (category != null) {
        queryParameter['c'] = category;
        query = 'WHERE strCategory = $category';
      } else if (alcoholic != null) {
        queryParameter['a'] = alcoholic;
        query = 'WHERE strAlcoholic = $alcoholic';
      } else {
        throw DatasourceError(message: 'Oops, you need to specify a filter!');
      }

      if (await network.isConnected) {
        final response = await client.get(
          'filter.php',
          queryParameters: queryParameter,
        );

        if (response.statusCode != 200) {
          throw DatasourceError(
              message: 'Oh my, we have an error contacting TheCocktailDB');
        }

        final list = (response.data['drinks'] as List)
            .map((e) => CocktailItemModel.fromMap(e))
            .toList();
        return list;
      } else {
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
        print(result);
        return result.map((e) => CocktailItemModel.fromMap(e)).toList();
      }
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(
          message:
              'Sorry, something wen wrong searching for your cocktails, stay sober :(');
    }
  }
}
