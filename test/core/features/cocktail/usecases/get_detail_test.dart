import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_detail_test.mocks.dart';

@GenerateMocks([
  CocktailExternalDatasource,
  CocktailLocalDatasource,
  NetworkInfo,
  Cocktail,
])
void main() {
  final cocktail = MockCocktail();
  final externalDatasource = MockCocktailExternalDatasource();
  final localDatasource = MockCocktailLocalDatasource();
  final network = MockNetworkInfo();
  final usecase = GetDetailImpl(
    externalDatasource: externalDatasource,
    localDatasource: localDatasource,
    network: network,
  );

  test('Should get a cocktail details locally', () async {
    when(localDatasource.getDetails('73478')).thenAnswer((_) async => cocktail);

    final result = await usecase('73478');
    expect(result.fold(id, id), isA<Cocktail>());
  });

  test('Should get a cocktail details external in case of local error',
      () async {
    when(localDatasource.save(cocktail)).thenAnswer((_) async => 1);
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.getDetails('73478'))
        .thenAnswer((_) async => cocktail);
    when(localDatasource.getDetails('73478'))
        .thenThrow((_) async => DatasourceError());

    final result = await usecase('73478');
    expect(result.fold(id, id), isA<Cocktail>());
  });

  test('Should not fail at saving failure', () async {
    when(localDatasource.save(cocktail)).thenThrow(Exception());
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.getDetails('73478'))
        .thenAnswer((_) async => cocktail);
    when(localDatasource.getDetails('73478'))
        .thenThrow((_) async => DatasourceError());

    final result = await usecase('73478');
    expect(result.fold(id, id), isA<Cocktail>());
  });

  test('Should deal with external error', () async {
    when(localDatasource.getDetails('73478'))
        .thenThrow((_) async => DatasourceError());
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.getDetails('73478'))
        .thenThrow((_) async => DatasourceError());

    var result = await usecase('73478');
    expect(result.fold(id, id), isA<DatasourceError>());

    when(externalDatasource.getDetails('73478'))
        .thenThrow((_) async => Exception());

    result = await usecase('73478');
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
