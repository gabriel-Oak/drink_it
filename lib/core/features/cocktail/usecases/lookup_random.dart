import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';

abstract class LookupRandom {
  Future<Either<FailureGetCocktails, Cocktail>> call();
}

class LookupRandomImpl extends LookupRandom {
  final CocktailExternalDatasource externalDatasource;
  final CocktailLocalDatasource localDatasource;

  LookupRandomImpl({
    required this.externalDatasource,
    required this.localDatasource,
  });

  @override
  Future<Either<FailureGetCocktails, Cocktail>> call() async {
    try {
      final cocktail = await externalDatasource.lookupRandom();

      try {
        localDatasource.save(cocktail);
      } catch (e) {
        print(e.toString());
      }

      return Right(cocktail);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError(message: 'Something went wrong with lookup'));
    }
  }
}
