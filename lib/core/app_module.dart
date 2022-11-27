import 'package:drink_it/core/db/db.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_external_datasource.dart';
import 'package:drink_it/core/features/cocktail/datasources/cocktail_local_datasource.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/core/utils/cocktail_client.dart';
import 'package:drink_it/core/utils/network_info.dart';
import 'package:drink_it/pages/home/home_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        // Globals
        Bind.singleton((i) => cocktailClient),
        Bind.singleton((i) => DbImpl()),
        Bind.singleton((i) => NetworkInfoImpl()),

        // Cocktail Feature
        Bind((i) => CocktailLocalDatasourceImpl(db: i())),
        Bind((i) => CocktailExternallDatasourceImpl(client: i())),
        Bind((i) => GetDetailImpl(
              externalDatasource: i(),
              localDatasource: i(),
              network: i(),
            )),
        Bind((i) => SearchByAlcoholicImpl(
              externalDatasource: i(),
              localDatasource: i(),
              network: i(),
            )),
        Bind((i) => SearchByCategoryImpl(
              externalDatasource: i(),
              localDatasource: i(),
              network: i(),
            )),
        Bind((i) => SearchByIngredientsImpl(
              externalDatasource: i(),
              localDatasource: i(),
              network: i(),
            )),

        // HomePage
        Bind((i) => HomeBloc(
              getDetails: i(),
              searchByAlcoholic: i(),
              searchByCategory: i(),
              searchByIngredient: i(),
            ))
      ];
}
