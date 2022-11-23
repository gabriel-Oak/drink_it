import 'dart:async';
import 'dart:convert';

import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/db/scripts/cocktails_table.dart';
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

  test('Should get List<CokctailItemModel> from database by vodka', () async {
    final FutureOr<List<Map<String, Object?>>> mock =
        Future.value((jsonDecode(cocktailsListMock)['drinks'] as List).map((e) {
      return e as Map<String, Object?>;
    }).toList());

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
    expect(results, isA<List<CocktailItem>>());
  });

  test('Should get List<CokctailItemModel> from database by beer', () async {
    final FutureOr<List<Map<String, Object?>>> mock =
        Future.value((jsonDecode(cocktailsListMock)['drinks'] as List).map((e) {
      return e as Map<String, Object?>;
    }).toList());

    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      'cocktails',
      columns: [
        'idDrink',
        'strDrink',
        'strDrinkThumb',
      ],
      where: 'WHERE LOWER(strCategory) = LOWER(beer)',
    )).thenAnswer((_) async => mock);

    final results = await datasource.getCocktails(category: 'beer');
    expect(results, isA<List<CocktailItem>>());
  });

  test('Should get List<CokctailItemModel> from database by alcoholic',
      () async {
    final FutureOr<List<Map<String, Object?>>> mock =
        Future.value((jsonDecode(cocktailsListMock)['drinks'] as List).map((e) {
      return e as Map<String, Object?>;
    }).toList());

    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      'cocktails',
      columns: [
        'idDrink',
        'strDrink',
        'strDrinkThumb',
      ],
      where: 'WHERE LOWER(strAlcoholic) = LOWER(alcoholic)',
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
      'cocktails',
      columns: cocktailsColumns,
      where: 'WHERE idDrink = ?',
      whereArgs: ['11118'],
    )).thenAnswer((_) async => mock);

    final results = await datasource.getDetails('11118');
    expect(results, isA<Cocktail>());
  });

  test('Should not return a cocktail', () async {
    final List<Map<String, Object?>> mock = [];
    when(db.get()).thenAnswer((_) async => database);
    when(database.query(
      'cocktails',
      columns: cocktailsColumns,
      where: 'WHERE idDrink = ?',
      whereArgs: ['11118'],
    )).thenAnswer((_) async => mock);

    final results = datasource.getDetails('11118');
    expect(results, throwsA(isA<DatasourceError>()));
  });

  test('Should save a cocktail in database', () async {
    final cocktail = Cocktail.fromMap(
        (jsonDecode(cocktailsSearchMock)['drinks'] as List).first);
    when(db.get()).thenAnswer((_) async => database);
    when(database.insert(
      'cocktail',
      cocktail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )).thenAnswer((_) async => 1);

    final result = await datasource.save(cocktail);
    expect(result, 1);
  });

  test('Should deal with error saving a cocktail in database', () async {
    final cocktail = Cocktail.fromMap(
        (jsonDecode(cocktailsSearchMock)['drinks'] as List).first);
    when(db.get()).thenAnswer((_) async => database);
    when(database.insert(
      'cocktail',
      cocktail.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    )).thenThrow((_) async => Exception());

    final result = datasource.save(cocktail);
    expect(result, throwsA(isA<DatasourceError>()));
  });
}
