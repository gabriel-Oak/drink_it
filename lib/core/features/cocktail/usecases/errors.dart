import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';

class LookUpRandomCocktailError extends FailureGetCocktails {
  LookUpRandomCocktailError()
      : super(message: 'Something went wrong finding a random cocktail');
}
