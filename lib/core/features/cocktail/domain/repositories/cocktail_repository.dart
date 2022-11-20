import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/domain/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/domain/entities/cocktail_item.dart';

abstract class CocktailRepository {
  Future<Either<FailureGetIngredients, List<CocktailItem>>> getByIngredient(
    String ingredientName,
  );
}
