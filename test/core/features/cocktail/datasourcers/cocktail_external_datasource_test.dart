import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../cocktails_list_mocks.dart';
import '../cocktails_search_mocks.dart';
import 'cocktail_external_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  final client = MockDio();
  final datasource = CocktailExternallDatasourceImpl(client: client);

  test('Should get cocktails by vodka and return List<CokctailItemModel>',
      () async {
    when(client.get('filter.php', queryParameters: {'i': 'vodka'})).thenAnswer(
      (_) async => Response(
        data: jsonDecode(cocktailsListMock),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final results = await datasource.getCocktails(ingredient: 'vodka');
    expect(results, isA<List<CocktailItem>>());
    expect(results[0].id, '15346');
  });

  test('Should get cocktails by alcoholic and return List<CokctailItemModel>',
      () async {
    when(client.get('filter.php', queryParameters: {'a': 'alcoholic'}))
        .thenAnswer(
      (_) async => Response(
        data: jsonDecode(cocktailsListMock),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final results = await datasource.getCocktails(alcoholic: 'alcoholic');
    expect(results, isA<List<CocktailItem>>());
    expect(results[0].id, '15346');
  });

  test('Should get cocktails by beer and return List<CokctailItemModel>',
      () async {
    when(client.get('filter.php', queryParameters: {'c': 'beer'})).thenAnswer(
      (_) async => Response(
        data: jsonDecode(cocktailsListMock),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final results = await datasource.getCocktails(category: 'beer');
    expect(results, isA<List<CocktailItem>>());
    expect(results[0].id, '15346');
  });

  test('Should deal with http error', () async {
    when(client.get('filter.php', queryParameters: {'i': 'vodka'})).thenAnswer(
      (_) async => Response(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final future = datasource.getCocktails(ingredient: 'vodka');
    expect(future, throwsA(isA<DatasourceError>()));
  });

  test('Should throw when no filter', () async {
    final results = datasource.getCocktails();
    expect(results, throwsA(isA<DatasourceError>()));
  });

  test('Should return a cocktail', () async {
    when(client.get('lookup.php', queryParameters: {'i': '11007'})).thenAnswer(
      (_) async => Response(
        data: jsonDecode(cocktailsSearchMock),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final results = await datasource.getDetails('11007');
    expect(results, isA<Cocktail>());
  });

  test('Should deal with cocktail search error', () async {
    when(client.get('lookup.php', queryParameters: {'i': '11007'})).thenAnswer(
      (_) async => Response(
        data: {},
        statusCode: 400,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final results = datasource.getDetails('11007');
    expect(results, throwsA(isA<DatasourceError>()));
  });
}
