import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/utils/network_info.dart';

abstract class SearchByCategory {
  Future<Either<FailureGetCocktails, List<CocktailItem>>> call(
    String categoryName,
  );
}

class SearchByCategoryImpl extends SearchByCategory {
  final CocktailExternalDatasource externalDatasource;
  final CocktailLocalDatasource localDatasource;
  final NetworkInfo network;

  SearchByCategoryImpl({
    required this.localDatasource,
    required this.network,
    required this.externalDatasource,
  });

  @override
  Future<Either<FailureGetCocktails, List<CocktailItem>>> call(
    String categoryName,
  ) async {
    if (categoryName.isEmpty) return Left(InvalidSearchError());

    try {
      final results = await network.isConnected
          ? await externalDatasource.getCocktails(category: categoryName)
          : await localDatasource.getCocktails(category: categoryName);
      return Right(results);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError(message: e.toString()));
    }
  }
}
