import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_by_category_test.mocks.dart';

@GenerateMocks([
  CocktailLocalDatasource,
  CocktailExternalDatasource,
  NetworkInfo,
])
void main() {
  final localDatasource = MockCocktailLocalDatasource();
  final externalDatasource = MockCocktailExternalDatasource();
  final network = MockNetworkInfo();
  final usecase = SearchByCategoryImpl(
    externalDatasource: externalDatasource,
    localDatasource: localDatasource,
    network: network,
  );

  test('Should return a list of cocktail options external', () async {
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.getCocktails(category: 'beer'))
        .thenAnswer((_) async => <CocktailItem>[]);

    final results = await usecase('beer');
    expect(results.fold(id, id), isA<List<CocktailItem>>());
  });

  test('Should return a list of cocktail options local', () async {
    when(network.isConnected).thenAnswer((_) async => false);
    when(localDatasource.getCocktails(category: 'beer'))
        .thenAnswer((_) async => <CocktailItem>[]);

    final results = await usecase('beer');
    expect(results.fold(id, id), isA<List<CocktailItem>>());
  });

  test('Should throw a InvalidSearchError', () async {
    final results = await usecase('');
    expect(results.fold(id, id), isA<InvalidSearchError>());
  });

  test('Should throw a DatasourceError for external', () async {
    when(network.isConnected).thenAnswer((_) async => true);
    when(externalDatasource.getCocktails(category: 'beer'))
        .thenThrow((_) async => DatasourceError(message: 'Oh Oh'));

    final results = await usecase('beer');
    expect(results.fold(id, id), isA<DatasourceError>());
  });

  test('Should throw a DatasourceError for local', () async {
    when(network.isConnected).thenAnswer((_) async => false);
    when(localDatasource.getCocktails(category: 'beer'))
        .thenThrow((_) async => DatasourceError(message: 'Oh Oh'));

    final results = await usecase('beer');
    expect(results.fold(id, id), isA<DatasourceError>());
  });
}
