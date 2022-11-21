import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/data/datasources/cocktail_datasource.dart';
import 'package:drink_it/core/features/cocktail/data/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/data/repositories/cocktail_repository_impl.dart';
import 'package:drink_it/core/features/cocktail/domain/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/domain/entities/cocktail_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cocktail_repository_impl_test.mocks.dart';

@GenerateMocks([CocktailDatasource])
void main() {
  final dataSource = MockCocktailDatasource();
  final repository = CocktailRepositoryImpl(datasource: dataSource);

  test('Should return a list of CocktailItem', () async {
    when(dataSource.getCocktails(ingredient: 'vodka'))
        .thenAnswer((_) async => const <CocktailItemModel>[]);

    final result = await repository.getByIngredient('vodka');
    expect(result.fold(id, id), isA<List<CocktailItem>>());
  });

  test('Should return a DatasourceError', () async {
    when(dataSource.getCocktails(ingredient: 'vodka'))
        .thenThrow((_) async => Exception());

    final result = await repository.getByIngredient('vodka');
    expect(result.fold(id, id), isA<DatasourceError>());
  });
}
