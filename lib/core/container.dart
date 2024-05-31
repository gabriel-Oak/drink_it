import 'package:dio/dio.dart';
import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_v2_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
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
      externalDatasource: container<CocktailV2ExternalDatasourceImpl>(),
      localDatasource: container<CocktailV2LocalDatasourceImpl>(),
      network: container<NetworkInfo>()));
}
