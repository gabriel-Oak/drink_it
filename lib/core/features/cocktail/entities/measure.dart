import 'package:drink_it/core/features/cocktail/entities/ingredient.dart';
import 'package:drink_it/core/utils/json_codable.dart';

class Measure implements JsonCodable {
  final String name;
  final Ingredient ingredient;

  Measure({
    required this.name,
    required this.ingredient,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredient': ingredient.toJson(),
    };
  }

  static Measure fromJson(Map<String, dynamic> json) {
    return Measure(
      name: json['measure'],
      ingredient: Ingredient.fromJson(json['ingredient']),
    );
  }
}
