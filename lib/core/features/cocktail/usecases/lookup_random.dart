import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/errors.dart';
import 'package:drink_it/core/utils/network_info.dart';

abstract class LookupRandom {
  Future<Either<FailureGetCocktails, ShallowCocktail>> call();
}

class LookupRandomImpl extends LookupRandom {
  final CocktailV2ExternalDatasource externalDatasource;
  final CocktailV2LocalDatasource localDatasource;
  final NetworkInfo network;

  LookupRandomImpl({
    required this.externalDatasource,
    required this.localDatasource,
    required this.network,
  });

  @override
  Future<Either<FailureGetCocktails, ShallowCocktail>> call() async {
    try {
      final isConnected = await network.isConnected;
      final cocktail = isConnected
          ? await externalDatasource.lookupRandom()
          : await localDatasource.lookupRandom();

      return Right(cocktail);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(LookUpRandomCocktailError());
    }
  }
}
