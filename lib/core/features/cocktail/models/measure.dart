import 'package:drink_it/core/features/cocktail/models/ingredient.dart';

class Measure {
  final String? id;
  final String? measure;
  final Ingredient ingredient;

  Measure({required this.ingredient, this.id, this.measure});

  Map<String, String?> toMap(cocktailId) => {
        "id": id,
        "measure": measure,
        "cocktail_id": cocktailId,
        "ingredient_id": ingredient.id
      };
}
