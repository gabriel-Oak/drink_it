import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/errors.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../cocktail.mock.dart';
import 'lookup_random.mocks.dart';

@GenerateMocks([
  CocktailV2LocalDatasource,
  CocktailV2ExternalDatasource,
  NetworkInfo,
])
void main() {
  final externalDatasourceMock = MockCocktailV2ExternalDatasource();
  final localDatasourceMock = MockCocktailV2LocalDatasource();
  final networkInfoMock = MockNetworkInfo();

  final LookupRandom usecase = LookupRandomImpl(
    externalDatasource: externalDatasourceMock,
    localDatasource: localDatasourceMock,
    network: networkInfoMock,
  );

  group('LookupRandomImpl Tests', () {
    test('should find random externally', () async {
      when(networkInfoMock.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(externalDatasourceMock.lookupRandom()).thenAnswer(
          (realInvocation) async => ShallowCocktail.fromJson(cocktailJsonMock));

      final result = await usecase();
      expect(result, isA<Right<FailureGetCocktails, ShallowCocktail>>());
    });

    test('should find random locally', () async {
      when(networkInfoMock.isConnected)
          .thenAnswer((realInvocation) async => false);
      when(localDatasourceMock.lookupRandom()).thenAnswer(
          (realInvocation) async => ShallowCocktail.fromJson(cocktailJsonMock));

      final result = await usecase();
      expect(result, isA<Right<FailureGetCocktails, ShallowCocktail>>());
    });

    test('should return datasource error finding random externally', () async {
      when(networkInfoMock.isConnected)
          .thenAnswer((realInvocation) async => true);
      when(externalDatasourceMock.lookupRandom()).thenThrow(DatasourceError());

      final result = await usecase();
      expect(result.fold(id, id), isA<DatasourceError>());
    });

    test('should return datasource error finding random locally', () async {
      when(networkInfoMock.isConnected)
          .thenAnswer((realInvocation) async => false);
      when(localDatasourceMock.lookupRandom()).thenThrow(DatasourceError());

      final result = await usecase();
      expect(result.fold(id, id), isA<DatasourceError>());
    });

    test('should return error on uncaught', () async {
      when(networkInfoMock.isConnected).thenThrow(Exception());
      final result = await usecase();

      expect(result.fold(id, id), isA<LookUpRandomCocktailError>());
    });
  });
}
