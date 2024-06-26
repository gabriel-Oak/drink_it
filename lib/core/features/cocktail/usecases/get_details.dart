// ignore_for_file: avoid_print

import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/utils/network_info.dart';

abstract class GetDetails {
  Future<Either<FailureGetCocktails, CocktailV2>> call(String cocktailId);
}

class GetDetailImpl extends GetDetails {
  final CocktailV2ExternalDatasource externalDatasource;
  final CocktailV2LocalDatasource localDatasource;
  final NetworkInfo network;

  GetDetailImpl({
    required this.externalDatasource,
    required this.localDatasource,
    required this.network,
  });

  @override
  Future<Either<FailureGetCocktails, CocktailV2>> call(
    String cocktailId,
  ) async {
    if (cocktailId.isEmpty) return Left(InvalidSearchError());
    try {
      final details = await localDatasource.getDetails(cocktailId);
      return Right(details);
    } catch (_) {
      try {
        if (!(await network.isConnected)) {
          return Left(DatasourceError(
              message:
                  'Sorry, couldn\'t find details, and you are offline too :('));
        }

        final details = await externalDatasource.getDetails(cocktailId);

        // ignore: invalid_return_type_for_catch_error
        localDatasource.save([details]).catchError(print);

        return Right(details);
      } on DatasourceError catch (e) {
        return Left(e);
      } catch (e) {
        return Left(DatasourceError(message: e.toString()));
      }
    }
  }
}
