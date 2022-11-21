import 'package:drink_it/core/features/cocktail/domain/entities/cocktail_item.dart';

class CocktailItemModel extends CocktailItem {
  CocktailItemModel(
      {required super.id, required super.name, required super.thumb});

  static CocktailItemModel fromMap(Map<String, dynamic> map) {
    return CocktailItemModel(
      id: map['idDrink'],
      name: map['strDrink'],
      thumb: map['strDrinkThumb'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumb': thumb,
    };
  }
}
