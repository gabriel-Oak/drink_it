import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

import 'cocktail_v2_local_datasource_test.mocks.dart';

@GenerateMocks([Db, Database])
void main() {
  final mockDb = MockDb();
  final mockDatabase = MockDatabase();
  final CocktailV2LocalDatasource datasource =
      CocktailV2LocalDatasourceImpl(db: mockDb);

  const cocktailsResultMock = [
    {
      'id': '15346',
      'name': '155 Belmont',
      'thumb':
          'https://www.thecocktaildb.com/images/media/drink/yqvvqs1475667388.jpg',
      'alcoholic': 'Alcoholic',
      'glass': 'White wine glass',
      'category': 'Cocktail',
      'instructions':
          'Blend with ice. Serve in a wine glass. Garnish with carrot.',
      'instructionsES': null,
      'instructionsDE':
          'Mit Eis vermischen. In einem Weinglas servieren. Mit Karotte garnieren.',
      'instructionsFR': null,
      'instructionsIT':
          'Miscela con ghiaccio.\rServire in un bicchiere da vino.\rGuarnire con una carota.',
    }
  ];

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
    test('Returns a list with cocktails', () async {
      when(mockDatabase.query(
        'cocktails_v2',
        where: argThat(isNotNull, named: 'where'),
        columns: argThat(isNotNull, named: 'columns'),
      )).thenAnswer((_) async => cocktailsResultMock);

      when(mockDatabase.rawQuery("""
            select distinct ME.cocktail_id,
            from measures ME
            left join ingredients IN on ME.ingredient_id = IN.id
            where IN.name like '%vodka%';
          """, null)).thenAnswer((_) async => [
            {'cocktail_id': '15346'}
          ]);

      when(mockDatabase.rawQuery("""
            select 
              ME.measure,
              IN.id as ingredient_id,
              IN.name as ingredient_name
            from measures ME
            left join ingredients IN on ME.ingredient_id = IN.id
            where ME.cocktail_id = '15346';
          """, null)).thenAnswer((_) async => measuresResultMock);

      final result = await datasource.getCocktails(ingredient: 'vodka');
      expect(result, isA<List<CocktailV2>>());
    });

    test('Returns an error when no filter param specified', () async {
      result() async => await datasource.getCocktails();
      expect(result, throwsA(const TypeMatcher<CocktailInvalidSearchError>()));
    });
  });
}
