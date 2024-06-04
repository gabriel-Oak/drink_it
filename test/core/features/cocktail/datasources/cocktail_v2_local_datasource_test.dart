import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import '../cocktail.mock.dart';
import 'cocktail_v2_local_datasource_test.mocks.dart';

@GenerateMocks([Db, Database])
void main() {
  final mockDb = MockDb();
  final mockDatabase = MockDatabase();
  final CocktailV2LocalDatasource datasource =
      CocktailV2LocalDatasourceImpl(db: mockDb);

  const cocktailsResultMock = [cocktailJsonMock];

  const measuresResultMock = [
    {
      'measure': '2 shots ',
      'ingredient_id': 'e886dd82-009c-432e-b8a6-3667315853ab',
      'ingredient_name': 'Light rum',
    },
  ];

  setUp(() {
    when(mockDb.get()).thenAnswer((_) async => mockDatabase);
  });

  group('CocktailV2LocalDatasourceImpl', () {
    group('getCocktails', () {
      test('Returns a list with cocktails', () async {
        when(mockDatabase.query(
          'cocktails_v2',
          where: argThat(isNotNull, named: 'where'),
          columns: argThat(isNotNull, named: 'columns'),
        )).thenAnswer((_) async => cocktailsResultMock);

        when(mockDatabase.rawQuery("""
            select distinct ME.cocktail_id,
            from measures ME
            left join ingredients IG on ME.ingredient_id = IG.id
            where IG.name like '%vodka%';
          """, null)).thenAnswer((_) async => [
              {'cocktail_id': '15346'}
            ]);

        when(mockDatabase.rawQuery("""
            select 
              ME.measure,
              IG.id as ingredient_id,
              IG.name as ingredient_name
            from measures ME
            left join ingredients IG on ME.ingredient_id = IG.id
            where ME.cocktail_id = '15346';
          """, null)).thenAnswer((_) async => measuresResultMock);

        final result = await datasource.getCocktails(ingredient: 'vodka');
        expect(result, isA<List<ShallowCocktail>>());
      });

      test('Returns an error when no filter param specified', () async {
        result() async => await datasource.getCocktails();
        expect(
            result, throwsA(const TypeMatcher<CocktailInvalidSearchError>()));
      });

      test('Returns an DatasourceError on caught Exception in getCocktails',
          () async {
        when(mockDatabase.rawQuery("""
            select distinct ME.cocktail_id,
            from measures ME
            left join ingredients IG on ME.ingredient_id = IG.id
            where IG.name like '%vodka%';
          """, null)).thenThrow(Exception());

        result() async => await datasource.getCocktails(ingredient: 'vodka');
        expect(result, throwsA(const TypeMatcher<DatasourceError>()));
      });
    });

    group('lookupRandom', () {
      test('Returns a random cocktail', () async {
        when(mockDatabase.query(
          'cocktails_v2',
          orderBy: 'RANDOM()',
          limit: 1,
          columns: argThat(isNotNull, named: 'columns'),
        )).thenAnswer((_) async => cocktailsResultMock);

        when(mockDatabase.rawQuery(any))
            .thenAnswer((_) async => measuresResultMock);

        final result = await datasource.lookupRandom();
        expect(result, isA<ShallowCocktail>());
      });

      test('Returns an error when no cocktails found', () async {
        when(mockDatabase.query(
          'cocktails_v2',
          orderBy: 'RANDOM()',
          limit: 1,
          columns: argThat(isNotNull, named: 'columns'),
        )).thenAnswer((_) async => []);

        result() async => await datasource.lookupRandom();
        expect(result, throwsA(const TypeMatcher<NoCocktailsSavedError>()));
      });

      test('Returns an DatasourceError on caught Exception in lookupRandom',
          () async {
        when(mockDatabase.query(
          'cocktails_v2',
          orderBy: 'RANDOM()',
          limit: 1,
          columns: argThat(isNotNull, named: 'columns'),
        )).thenThrow(Exception());

        result() async => await datasource.lookupRandom();
        expect(result, throwsA(const TypeMatcher<DatasourceError>()));
      });
    });

    group('save', () {
      test('Should save a cocktail', () async {
        when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);
        when(mockDatabase.transaction(any)).thenAnswer((_) async => 1);

        final result =
            await datasource.save([CocktailV2.fromJson(cocktailJsonMock)]);
        expect(result, 1);
      });
    });

    group('saveShallow', () {
      test('Should save a shallow cocktail', () async {
        when(mockDatabase.insert(any, any)).thenAnswer((_) async => 1);
        when(mockDatabase.transaction(any)).thenAnswer((_) async => 1);

        final result = await datasource
            .saveShallow([ShallowCocktail.fromJson(cocktailJsonMock)]);
        expect(result, 1);
      });
    });

    group('getDetails', () {
      test('Should return full cocktail', () async {
        when(mockDatabase.query(
          'cocktails_v2',
          limit: 1,
          columns: argThat(isNotNull, named: 'columns'),
        )).thenAnswer((_) async => cocktailsResultMock);

        when(mockDatabase.rawQuery(any))
            .thenAnswer((_) async => measuresResultMock);

        final result = await datasource.getDetails('15346');
        expect(result, isA<CocktailV2>());
      });

      test('Should return an error when no cocktails found', () async {
        when(mockDatabase.query(
          'cocktails_v2',
          limit: 1,
          columns: argThat(isNotNull, named: 'columns'),
        )).thenAnswer((_) async => []);

        result() async => await datasource.getDetails('15346');
        expect(result, throwsA(const TypeMatcher<NoCocktailsSavedError>()));
      });

      test('Should return an error when cocktail found has no instructions',
          () async {
        when(mockDatabase.query(
          'cocktails_v2',
          limit: 1,
          columns: argThat(isNotNull, named: 'columns'),
        )).thenAnswer((_) async => [
              {...cocktailJsonMock, 'instructions': null}
            ]);

        result() async => await datasource.getDetails('15346');
        expect(result, throwsA(const TypeMatcher<NoCocktailsSavedError>()));
      });
    });
  });
}
