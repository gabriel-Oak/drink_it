import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/data/datasources/cocktail_datasource.dart';
import 'package:drink_it/core/features/cocktail/data/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/domain/cocktail_errors.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../../cocktails_list_mocks.dart';
import 'cocktail_datasource_test.mocks.dart';

@GenerateMocks([Dio, NetworkInfo, Db, Database])
void main() {
  final client = MockDio();
  final networkInfo = MockNetworkInfo();
  final db = MockDb();
  final database = MockDatabase();
  final datasource = CocktailDatasourceImpl(
    client: client,
    db: db,
    network: networkInfo,
  );

  test('Should get cocktails by vodka and return List<CokctailItemModel>',
      () async {
    when(networkInfo.isConnected).thenAnswer((_) async => true);
    when(client.get('filter.php', queryParameters: {'i': 'vodka'})).thenAnswer(
      (_) async => Response(
        data: jsonDecode(cocktailsListMock),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    final results = await datasource.getCocktails(ingredient: 'vodka');
    expect(results, isA<List<CocktailItemModel>>());
    expect(results[0].id, '15346');
  });

  test('Should deal with http error', () async {
    when(networkInfo.isConnected).thenAnswer((_) async => true);
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

  test('Should get List<CokctailItemModel> from database', () async {
    final FutureOr<List<Map<String, Object?>>> mock =
        Future.value((jsonDecode(cocktailsListMock)['drinks'] as List).map((e) {
      return e as Map<String, Object?>;
    }).toList());

    when(networkInfo.isConnected).thenAnswer((_) async => false);
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      'cocktails',
      columns: [
        'idDrink',
        'strDrink',
        'strDrinkThumb',
      ],
      where: 'WHERE LOWER(strIngredient1) LIKE LOWER(\'%vodka%\')',
    )).thenAnswer((_) async => mock);

    final results = await datasource.getCocktails(ingredient: 'vodka');
    expect(results, isA<List<CocktailItemModel>>());
  });
}
