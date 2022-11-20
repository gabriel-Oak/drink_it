import 'package:drink_it/core/features/cocktail/data/models/cocktail_item_model.dart';

abstract class CocktailDatasource {
  Future<List<CocktailItemModel>> getCocktails({String name});
}
