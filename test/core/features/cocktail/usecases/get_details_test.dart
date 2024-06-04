import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../cocktail.mock.dart';
import 'get_details_test.mocks.dart';

@GenerateMocks([
  CocktailV2LocalDatasource,
  CocktailV2ExternalDatasource,
  NetworkInfo,
])
void main() {
  final localDatasourceMock = MockCocktailV2LocalDatasource();
  final externalDatasourceMock = MockCocktailV2ExternalDatasource();
  final networkInfoMock = MockNetworkInfo();
  final GetDetails usecase = GetDetailImpl(
    externalDatasource: externalDatasourceMock,
    localDatasource: localDatasourceMock,
    network: networkInfoMock,
  );

  group('GetDetailImpl tests', () {
    test('Should return error when cocktailId is empty', () async {
      final result = await usecase('');
      expect(result.fold(id, id), isA<InvalidSearchError>());
    });

    test('Should return local storage details', () async {
      when(localDatasourceMock.getDetails('15346'))
          .thenAnswer((_) async => CocktailV2.fromJson(cocktailJsonMock));

      final result = await usecase('15346');
      expect(result, isA<Right<FailureGetCocktails, CocktailV2>>());
    });

    test('Should return not connected error', () async {
      when(localDatasourceMock.getDetails('15346'))
          .thenThrow(NoCocktailsSavedError());
      when(networkInfoMock.isConnected).thenAnswer((_) async => false);

      final result = await usecase('15346');
      expect(result, isA<Left<FailureGetCocktails, CocktailV2>>());
    });

    test('Should return external cocktail details', () async {
      when(localDatasourceMock.getDetails('15346'))
          .thenThrow(NoCocktailsSavedError());
      when(networkInfoMock.isConnected).thenAnswer((_) async => true);
      when(externalDatasourceMock.getDetails('15346'))
          .thenAnswer((_) async => CocktailV2.fromJson(cocktailJsonMock));

      final result = await usecase('15346');
      expect(result, isA<Left<FailureGetCocktails, CocktailV2>>());
    });
  });
}
