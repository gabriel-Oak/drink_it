import 'package:dio/dio.dart';
import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/core/utils/cocktail_client.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:get_it/get_it.dart';

final GetIt container = GetIt.instance;

void setupContainer() {
  // Globals
  container.registerFactory<Dio>(() => graphQLClient);
  container.registerSingleton<Db>(DbImpl());
  container.registerSingleton<NetworkInfo>(NetworkInfoImpl());

  // Cocktail Feature
  container.registerLazySingleton<CocktailV2LocalDatasource>(
      () => CocktailV2LocalDatasourceImpl(db: container<Db>()));
  container.registerLazySingleton<CocktailV2ExternalDatasource>(
      () => CocktailV2ExternalDatasourceImpl(graphQlClient: container<Dio>()));
  container.registerLazySingleton<LookupRandom>(() => LookupRandomImpl(
      externalDatasource: container<CocktailV2ExternalDatasource>(),
      localDatasource: container<CocktailV2LocalDatasource>(),
      network: container<NetworkInfo>()));
  container.registerLazySingleton<SearchByAlcoholic>(() =>
      SearchByAlcoholicImpl(
          externalDatasource: container<CocktailV2ExternalDatasource>(),
          localDatasource: container<CocktailV2LocalDatasource>(),
          network: container<NetworkInfo>()));
  container.registerLazySingleton<SearchByIngredients>(() =>
      SearchByIngredientsImpl(
          externalDatasource: container<CocktailV2ExternalDatasource>(),
          localDatasource: container<CocktailV2LocalDatasource>(),
          network: container<NetworkInfo>()));
  container.registerLazySingleton<SearchByCategory>(() => SearchByCategoryImpl(
      externalDatasource: container<CocktailV2ExternalDatasource>(),
      localDatasource: container<CocktailV2LocalDatasource>(),
      network: container<NetworkInfo>()));
  container.registerLazySingleton<GetDetails>(() => GetDetailImpl(
      externalDatasource: container<CocktailV2ExternalDatasource>(),
      localDatasource: container<CocktailV2LocalDatasource>(),
      network: container<NetworkInfo>()));
}
