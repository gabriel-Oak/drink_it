import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';

abstract class GetDetails {
  Future<Either<FailureGetCocktails, Cocktail>> call(String cocktailId);
}

class GetDetailImpl extends GetDetails {
  @override
  Future<Either<FailureGetCocktails, Cocktail>> call(String cocktailId) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
