import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/domain/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/domain/entities/cocktail_item.dart';
import 'package:drink_it/core/features/cocktail/domain/repositories/cocktail_repository.dart';
import 'package:drink_it/core/features/cocktail/domain/usecases/seach_by_ingredient.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_by_ingredient_test.mocks.dart';

@GenerateMocks([CocktailRepository])
void main() {
  final repository = MockCocktailRepository();
  final usecase = SearchByIngredientsImpl(cocktailRepository: repository);

  test('Should return a list of cocktail options', () async {
    when(repository.getByIngredient('vodka'))
        .thenAnswer((_) async => const Right(<CocktailItem>[]));

    final results = await usecase('vodka');
    expect(results.fold(id, id), isA<List<CocktailItem>>());
  });

  test('Should throw a InvalidSearchError', () async {
    when(repository.getByIngredient('vodka'))
        .thenAnswer((_) async => const Right(<CocktailItem>[]));

    final results = await usecase('');
    expect(results.fold(id, id), isA<InvalidSearchError>());
  });
}
