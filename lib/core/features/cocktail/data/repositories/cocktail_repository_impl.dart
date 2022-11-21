import 'package:drink_it/core/features/cocktail/data/datasources/cocktail_datasource.dart';
import 'package:drink_it/core/features/cocktail/domain/entities/cocktail_item.dart';
import 'package:drink_it/core/features/cocktail/domain/cocktail_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/domain/repositories/cocktail_repository.dart';

class CocktailRepositoryImpl extends CocktailRepository {
  final CocktailDatasource datasource;

  CocktailRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<FailureGetCocktails, List<CocktailItem>>> getByIngredient(
    String ingredientName,
  ) async {
    try {
      final results = await datasource.getCocktails(ingredient: ingredientName);
      return Right(results);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError(message: e.toString()));
    }
  }
}
