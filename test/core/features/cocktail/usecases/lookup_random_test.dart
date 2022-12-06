import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'lookup_random.mocks.dart';

@GenerateMocks([
  CocktailExternalDatasource,
  CocktailLocalDatasource,
  Cocktail,
])
void main() {
  final localDatasource = MockCocktailLocalDatasource();
  final externalDatasource = MockCocktailExternalDatasource();
  final cocktail = MockCocktail();

  final usecase = LookupRandomImpl(
    externalDatasource: externalDatasource,
    localDatasource: localDatasource,
  );

  test('Should return a cocktail', () async {
    when(externalDatasource.lookupRandom())
        .thenAnswer((realInvocation) async => cocktail);
    when(localDatasource.save(cocktail)).thenAnswer((_) async => 1);

    final result = await usecase();
    expect(result.fold(id, id), isA<Cocktail>());
  });

  test('Should return deal with errors', () async {
    when(externalDatasource.lookupRandom()).thenThrow(
        (_) async => DatasourceError(message: 'Ding ding ding motherfocker'));

    final result = await usecase();
    expect(result.fold(id, id), isA<FailureGetCocktails>());
  });

  test('Should return a cocktail and deal with save errors', () async {
    when(externalDatasource.lookupRandom())
        .thenAnswer((realInvocation) async => cocktail);
    when(localDatasource.save(cocktail))
        .thenThrow((_) async => DatasourceError(message: 'could not save'));

    final result = await usecase();
    expect(result.fold(id, id), isA<Cocktail>());
  });
}
