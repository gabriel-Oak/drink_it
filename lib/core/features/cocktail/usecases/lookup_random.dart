import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/core/utils/network_info.dart';

abstract class LookupRandom {
  Future<Either<FailureGetCocktails, Cocktail>> call();
}

class LookupRandomImpl extends LookupRandom {
  final CocktailExternalDatasource externalDatasource;
  final CocktailLocalDatasource localDatasource;
  final NetworkInfo network;

  LookupRandomImpl({
    required this.externalDatasource,
    required this.localDatasource,
    required this.network,
  });

  @override
  Future<Either<FailureGetCocktails, Cocktail>> call() async {
    try {
      final isConnected = await network.isConnected;
      final cocktail = isConnected
          ? await externalDatasource.lookupRandom()
          : await localDatasource.lookupRandom();

      try {
        if (isConnected) localDatasource.save(cocktail);
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
