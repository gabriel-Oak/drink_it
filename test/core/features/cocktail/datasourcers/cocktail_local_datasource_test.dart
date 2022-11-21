import 'dart:async';
import 'dart:convert';

import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../cocktails_list_mocks.dart';
import 'cocktail_local_datasource_test.mocks.dart';

@GenerateMocks([Database, Db])
void main() {
  final db = MockDb();
  final database = MockDatabase();
  final datasource = CocktailLocalDatasourceImpl(db: db);

  test('Should get List<CokctailItemModel> from database', () async {
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
}
