import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'lookup_random_test.mocks.dart';

@GenerateMocks([
  CocktailExternalDatasource,
  CocktailLocalDatasource,
  Cocktail,
  NetworkInfo,
])
void main() {
  final localDatasource = MockCocktailLocalDatasource();
  final externalDatasource = MockCocktailExternalDatasource();
  final cocktail = MockCocktail();
  final network = MockNetworkInfo();

  final usecase = LookupRandomImpl(
    externalDatasource: externalDatasource,
    localDatasource: localDatasource,
    network: network,
  );

  test('Should return a cocktail', () async {
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.lookupRandom())
        .thenAnswer((realInvocation) async => cocktail);
    when(localDatasource.save(cocktail)).thenAnswer((_) async => 1);

    final result = await usecase();
    expect(result.fold(id, id), isA<Cocktail>());
  });

  test('Should return deal with errors', () async {
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.lookupRandom()).thenThrow(
        (_) async => DatasourceError(message: 'Ding ding ding motherfocker'));

    final result = await usecase();
    expect(result.fold(id, id), isA<FailureGetCocktails>());
  });

  test('Should return a cocktail and deal with save errors', () async {
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.lookupRandom()).thenAnswer((_) async => cocktail);
    when(localDatasource.save(cocktail))
        .thenThrow((_) async => DatasourceError(message: 'could not save'));

    final result = await usecase();
    expect(result.fold(id, id), isA<Cocktail>());
  });

  test('Should search locally when no internet', () async {
    when(network.isConnected).thenAnswer((_) async => false);
    when(localDatasource.lookupRandom()).thenAnswer((_) async => cocktail);
    when(localDatasource.save(cocktail))
        .thenThrow((_) async => DatasourceError(message: 'could not save'));

    final result = await usecase();
    expect(result.fold(id, id), isA<Cocktail>());
  });
}
