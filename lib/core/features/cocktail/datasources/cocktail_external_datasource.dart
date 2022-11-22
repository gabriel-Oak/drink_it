import 'package:dio/dio.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';

abstract class CocktailExternalDatasource {
  Future<Cocktail> getDetails(String id);
  Future<List<CocktailItem>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  });
}

class CocktailDatasourceImpl extends CocktailExternalDatasource {
  final Dio client;

  CocktailDatasourceImpl({
    required this.client,
  });

  @override
  Future<List<CocktailItem>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  }) async {
    try {
      final Map<String, String> queryParameter = {};
      if (ingredient != null) {
        queryParameter['i'] = ingredient;
      } else if (category != null) {
        queryParameter['c'] = category;
      } else if (alcoholic != null) {
        queryParameter['a'] = alcoholic;
      } else {
        throw DatasourceError(message: 'Oops, you need to specify a filter!');
      }

      final response = await client.get(
        'filter.php',
        queryParameters: queryParameter,
      );

      if (response.statusCode != 200) {
        throw DatasourceError(
            metadata: response.data.toString(),
            message: 'Oh my, we have an error contacting TheCocktailDB');
      }

      final list = (response.data['drinks'] as List)
          .map((e) => CocktailItem.fromMap(e))
          .toList();
      return list;
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
      final response = await client.get(
        'lookup.php',
        queryParameters: {'i': id},
      );

      if (response.statusCode != 200) {
        throw DatasourceError(
            metadata: response.data.toString(),
            message: 'Oh my, we have an error searching in TheCocktailDB');
      }

      return Cocktail.fromMap((response.data['drinks'] as List).first);
    } on DatasourceError {
      rethrow;
    } catch (e) {
      throw DatasourceError(
        metadata: e.toString(),
        message: 'Oops could\'t find your cocktail :(',
      );
    }
  }
}
