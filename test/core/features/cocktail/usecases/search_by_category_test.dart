import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../cocktail.mock.dart';
import 'search_by_category_test.mocks.dart';

@GenerateMocks([
  CocktailV2LocalDatasource,
  CocktailV2ExternalDatasource,
  NetworkInfo,
])
void main() {
  final localDatasourceMock = MockCocktailV2LocalDatasource();
  final externalDatasourceMock = MockCocktailV2ExternalDatasource();
  final networkInfoMock = MockNetworkInfo();
  final SearchByCategory usecase = SearchByCategoryImpl(
    localDatasource: localDatasourceMock,
    network: networkInfoMock,
    externalDatasource: externalDatasourceMock,
  );

  group('SearchByCategoryImpl tests', () {
    test('Should return list of cocktails externally', () async {
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
      when(externalDatasourceMock.getCocktails(category: 'punch')).thenAnswer(
          (_) async => [ShallowCocktail.fromJson(cocktailJsonMock)]);

      final result = await usecase('punch');
      expect(result, isA<Right<FailureGetCocktails, List<ShallowCocktail>>>());
    });

    test('Should return list of cocktails locally', () async {
      when(networkInfoMock.isConnected).thenAnswer((_) async => false);
      when(localDatasourceMock.getCocktails(category: 'punch')).thenAnswer(
          (_) async => [ShallowCocktail.fromJson(cocktailJsonMock)]);

      final result = await usecase('punch');
      expect(result, isA<Right<FailureGetCocktails, List<ShallowCocktail>>>());
    });

    test('Should return left on datasource error', () async {
      when(networkInfoMock.isConnected).thenAnswer((_) async => false);
      when(localDatasourceMock.getCocktails(category: 'punch'))
          .thenThrow(DatasourceError());

      final result = await usecase('punch');
      expect(result, isA<Left<FailureGetCocktails, List<ShallowCocktail>>>());
    });

    test('Should return left on uncaught error', () async {
      when(networkInfoMock.isConnected).thenThrow(Exception());

      final result = await usecase('punch');
      expect(result, isA<Left<FailureGetCocktails, List<ShallowCocktail>>>());
    });
  });
}
