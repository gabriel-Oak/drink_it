import 'package:dio/dio.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../cocktail.mock.dart';
import 'cocktail_v2_external_datasource_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  const getCocktailsResultMock = {
    'getCocktails': [cocktailJsonMock],
  };

  const lookUpRandomQueryMock = {
    'getRandomCocktail': cocktailJsonMock,
  };

  final graphQlClientMock = MockDio();
  final CocktailV2ExternalDatasource datasource =
      CocktailV2ExternalDatasourceImpl(graphQlClient: graphQlClientMock);

  group('CocktailV2ExternalDatasourceImpl Tests', () {
    group('getCocktails', () {
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

      test('Returns an DatasourceError on caught Exception in getCocktails',
          () async {
        when(graphQlClientMock.post(
          '/',
          data: argThat(isNotNull, named: 'data'),
        )).thenThrow(Exception());

        result() async => await datasource.getCocktails();
        expect(result, throwsA(const TypeMatcher<DatasourceError>()));
      });

      test('Returns an error when no filter param specified', () async {
        result() async => await datasource.getCocktails();
        expect(
            result, throwsA(const TypeMatcher<CocktailInvalidSearchError>()));
      });

      test('Returns an error when getCocktails request return != 200',
          () async {
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
    });

    group('lookupRandom', () {
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

      test('Returns an DatasourceError on caught Exception in lookupRandom',
          () async {
        when(graphQlClientMock.post(
          '/',
          data: argThat(isNotNull, named: 'data'),
        )).thenThrow(Exception());

        result() async => await datasource.lookupRandom();
        expect(result, throwsA(const TypeMatcher<DatasourceError>()));
      });

      test('Returns an error when lookupRandom request return != 200',
          () async {
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
  });
}
