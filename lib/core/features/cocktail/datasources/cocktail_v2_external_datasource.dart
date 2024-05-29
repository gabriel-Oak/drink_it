import 'package:dio/dio.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_queries.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';

abstract class CocktailV2ExternalDatasource {
  Future<List<CocktailV2>> getCocktails({
    String? ingredient,
    String? category,
    String? alcoholic,
  });
  Future<CocktailV2> lookupRandom();
}

class CocktailV2ExternalDatasourceImpl implements CocktailV2ExternalDatasource {
  final Dio graphQlClient;

  CocktailV2ExternalDatasourceImpl({required this.graphQlClient});

  @override
  Future<List<CocktailV2>> getCocktails({
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

      final response = await graphQlClient.post<Map<String, dynamic>>(
        '/',
        data: {
          'operationName': 'Query',
          'variables': {'query': queryParameter},
          'query': getCocktailsQuery
        },
      );

      if (response.statusCode != 200) {
        throw DatasourceError(
          metadata: response.data.toString(),
          message: 'Oh my, we have an error contacting our service',
        );
      }
      final list =
          (response.data!['data']['getCocktails'] as List<Map<String, dynamic>>)
              .map(CocktailV2.fromJson)
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
  Future<CocktailV2> lookupRandom() {
    // TODO: implement lookupRandom
    throw UnimplementedError();
  }
}
