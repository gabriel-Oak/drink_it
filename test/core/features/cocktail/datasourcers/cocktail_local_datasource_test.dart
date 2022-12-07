import 'dart:async';
import 'dart:convert';

import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../cocktails_list_mocks.dart';
import '../cocktails_search_mocks.dart';
import 'cocktail_local_datasource_test.mocks.dart';

@GenerateMocks([Database, Db])
void main() {
  final db = MockDb();
  final database = MockDatabase();
  final datasource = CocktailLocalDatasourceImpl(db: db);
  final cocktail = Cocktail.fromMap(
      (jsonDecode(cocktailsSearchMock)['drinks'] as List).first);
  final FutureOr<List<Map<String, Object?>>> mock =
      Future.value((jsonDecode(cocktailsListMock)['drinks'] as List).map((e) {
    return e as Map<String, Object?>;
  }).toList());

  test('Should get List<CokctailItemModel> from database by vodka', () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      where: anyNamed('where'),
    )).thenAnswer((_) async => mock);

    final results = await datasource.getCocktails(ingredient: 'vodka');
    expect(results, isA<List<CocktailItem>>());
  });

  test('Should get List<CokctailItemModel> from database by beer', () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      where: anyNamed('where'),
    )).thenAnswer((_) async => mock);

    final results = await datasource.getCocktails(category: 'beer');
    expect(results, isA<List<CocktailItem>>());
  });

  test('Should get List<CokctailItemModel> from database by alcoholic',
      () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      where: anyNamed('where'),
    )).thenAnswer((_) async => mock);

    final results = await datasource.getCocktails(alcoholic: 'alcoholic');
    expect(results, isA<List<CocktailItem>>());
  });

  test('Should throw when no filter', () async {
    final results = datasource.getCocktails();
    expect(results, throwsA(isA<DatasourceError>()));
  });

  test('Should return a cocktail', () async {
    final FutureOr<List<Map<String, Object?>>> mock =
        (jsonDecode(cocktailsSearchMock)['drinks'] as List)
            .sublist(0, 1)
            .map((e) {
      return e as Map<String, Object?>;
    }).toList();

    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      where: anyNamed('where'),
      whereArgs: anyNamed('whereArgs'),
    )).thenAnswer((_) async => mock);

    final results = await datasource.getDetails('11118');
    expect(results, isA<Cocktail>());
  });

  test('Should not return a cocktail', () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      where: anyNamed('where'),
      whereArgs: anyNamed('whereArgs'),
    )).thenAnswer((_) async => []);

    final results = datasource.getDetails('11118');
    expect(results, throwsA(isA<DatasourceError>()));
  });

  test('Should save a cocktail in database', () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.insert(
      any,
      any,
      conflictAlgorithm: anyNamed('conflictAlgorithm'),
    )).thenAnswer((_) async => 1);

    final result = await datasource.save(cocktail);
    expect(result, 1);
  });

  test('Should deal with error saving a cocktail in database', () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.insert(
      any,
      any,
      conflictAlgorithm: anyNamed('conflictAlgorithm'),
    )).thenThrow((_) async => Exception());

    final result = datasource.save(cocktail);
    expect(result, throwsA(isA<DatasourceError>()));
  });

  test('Should return a random cocktail', () async {
    final FutureOr<List<Map<String, Object?>>> mock =
        (jsonDecode(cocktailsSearchMock)['drinks'] as List).map((e) {
      return e as Map<String, Object?>;
    }).toList();

    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      limit: anyNamed('limit'),
      orderBy: anyNamed('orderBy'),
    )).thenAnswer((_) async => mock);

    final results = await datasource.lookupRandom();
    expect(results, isA<Cocktail>());
  });

  test('Should return error instead a random cocktail', () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      limit: anyNamed('limit'),
      orderBy: anyNamed('orderBy'),
    )).thenAnswer((_) async => []);

    final results = datasource.lookupRandom();
    expect(results, throwsA(isA<DatasourceError>()));
  });

  test('Should deal with errors looking for random cocktail', () async {
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      any,
      columns: anyNamed('columns'),
      limit: anyNamed('limit'),
      orderBy: anyNamed('orderBy'),
    )).thenThrow(Exception());

    final results = datasource.lookupRandom();
    expect(results, throwsA(isA<DatasourceError>()));
  });
}
