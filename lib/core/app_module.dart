import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/core/utils/cocktail_client.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:drink_it/pages/home/bloc/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    // Globals
    i.addSingleton(() => cocktailClient);
    i.addSingleton<Db>(DbImpl.new);
    i.addSingleton<NetworkInfo>(NetworkInfoImpl.new);

    // Cocktail Feature
    i.addSingleton<CocktailLocalDatasource>(CocktailLocalDatasourceImpl.new);
    i.addSingleton<CocktailExternalDatasource>(
        CocktailExternallDatasourceImpl.new);
    i.addSingleton<GetDetails>(GetDetailImpl_DEPRECIATED.new);
    i.addSingleton<SearchByAlcoholic>(SearchByAlcoholicImpl.new);
    i.addSingleton<SearchByCategory>(SearchByCategoryImpl.new);
    i.addSingleton<SearchByIngredients>(SearchByIngredientsImpl.new);
    i.addSingleton<LookupRandom>(LookupRandomImpl.new);

    // HomePage
    i.addSingleton(HomeBloc.new);
  }
}
