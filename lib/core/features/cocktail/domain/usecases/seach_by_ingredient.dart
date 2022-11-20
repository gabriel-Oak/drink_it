import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/domain/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/domain/entities/cocktail_item.dart';
import 'package:drink_it/core/features/cocktail/domain/repositories/cocktail_repository.dart';

abstract class SearchByIngredients {
  Future<Either<FailureGetIngredients, List<CocktailItem>>> call(
    String ingredientName,
  );
}

class SearchByIngredientsImpl extends SearchByIngredients {
  final CocktailRepository cocktailRepository;

  SearchByIngredientsImpl({required this.cocktailRepository});

  @override
  Future<Either<FailureGetIngredients, List<CocktailItem>>> call(
    String ingredientName,
  ) async {
    if (ingredientName.isEmpty) {
      return Left(InvalidSearchError());
    }
    return cocktailRepository.getByIngredient(ingredientName);
  }
}
