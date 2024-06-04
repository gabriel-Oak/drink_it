// ignore_for_file: avoid_print, invalid_return_type_for_catch_error

import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/utils/network_info.dart';

abstract class SearchByAlcoholic {
  Future<Either<FailureGetCocktails, List<ShallowCocktail>>> call(
    String alcoholic,
  );
}

class SearchByAlcoholicImpl extends SearchByAlcoholic {
  final CocktailV2ExternalDatasource externalDatasource;
  final CocktailV2LocalDatasource localDatasource;
  final NetworkInfo network;

  SearchByAlcoholicImpl({
    required this.localDatasource,
    required this.network,
    required this.externalDatasource,
  });

  @override
  Future<Either<FailureGetCocktails, List<ShallowCocktail>>> call(
    String alcoholic,
  ) async {
    List<ShallowCocktail> results;

    try {
      if (await network.isConnected) {
        results = await externalDatasource
            .getCocktails(alcoholic: alcoholic)
            .catchError((_) => <ShallowCocktail>[]);

        if (results.isNotEmpty) {
          localDatasource.saveShallow(results).catchError(print);
          return Right(results);
        }
      }

      results = await localDatasource.getCocktails(alcoholic: alcoholic);
      return Right(results);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError(message: e.toString()));
    }
  }
}
