import 'package:dio/dio.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cocktail_v2_external_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  const getCocktailsResultMock = {
    'getCocktails': [
      {
        'id': '15346',
        'name': '155 Belmont',
        'thumb':
            'https://www.thecocktaildb.com/images/media/drink/yqvvqs1475667388.jpg',
        'alcoholic': 'Alcoholic',
        'glass': 'White wine glass',
        'measures': [
          {
            'measure': '2 shots ',
            'ingredient': {
              'id': 'e886dd82-009c-432e-b8a6-3667315853ab',
              'name': 'Light rum'
            }
          },
        ],
        'category': 'Cocktail',
        'instructions':
            'Blend with ice. Serve in a wine glass. Garnish with carrot.',
        'instructionsES': null,
        'instructionsDE':
            'Mit Eis vermischen. In einem Weinglas servieren. Mit Karotte garnieren.',
        'instructionsFR': null,
        'instructionsIT':
            'Miscela con ghiaccio.\rServire in un bicchiere da vino.\rGuarnire con una carota.',
      },
    ],
  };

  const lookUpRandomQueryMock = {
    'getRandomCocktail': {
      'id': '16485',
      'name': 'Flaming Lamborghini',
      'thumb':
          'https://www.thecocktaildb.com/images/media/drink/yywpss1461866587.jpg',
      'category': 'Cocktail',
      'measures': [
        {
          'measure': '1 oz ',
          'ingredient': {
            'name': 'Kahlua',
          },
        },
      ],
    },
  };

  final graphQlClientMock = MockDio();
  final CocktailV2ExternalDatasource datasource =
      CocktailV2ExternalDatasourceImpl(graphQlClient: graphQlClientMock);

  group('CocktailV2ExternalDatasourceImpl Tests', () {
    test('Returns a list with cocktails', () async {
      when(graphQlClientMock.post(
        '/',
        data: argThat(isNotNull, named: 'data'),
      )).thenAnswer((_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: {'data': getCocktailsResultMock}));

      final result = await datasource.getCocktails(ingredient: 'vodka');
      expect(result, isA<List<CocktailV2>>());
    });

    test('Returns an error when no filter param specified', () async {
      result() async => await datasource.getCocktails();
      expect(result, throwsA(const TypeMatcher<CocktailInvalidSearchError>()));
    });

    test('Returns an error when getCocktails request return != 200', () async {
      when(graphQlClientMock.post(
        '/',
        data: argThat(isNotNull, named: 'data'),
      )).thenAnswer((_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(),
          statusCode: 400,
          data: {'data': getCocktailsResultMock}));

      result() async => await datasource.getCocktails(ingredient: 'i');
      expect(result, throwsA(const TypeMatcher<CocktailConnectionError>()));
    });

    test('Returns a single random cocktail', () async {
      when(graphQlClientMock.post(
        '/',
        data: argThat(isNotNull, named: 'data'),
      )).thenAnswer((_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: {'data': lookUpRandomQueryMock}));

      final result = await datasource.lookupRandom();
      expect(result, isA<ShallowCocktail>());
    });

    test('Returns an error when lookupRandom request return != 200', () async {
      when(graphQlClientMock.post(
        '/',
        data: argThat(isNotNull, named: 'data'),
      )).thenAnswer((_) async => Response<Map<String, dynamic>>(
          requestOptions: RequestOptions(),
          statusCode: 400,
          data: {'data': getCocktailsResultMock}));

      result() async => await datasource.lookupRandom();
      expect(result, throwsA(const TypeMatcher<CocktailConnectionError>()));
    });
  });
}
