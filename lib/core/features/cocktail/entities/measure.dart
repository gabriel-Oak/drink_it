import 'package:drink_it/core/features/cocktail/entities/ingredient.dart';
import 'package:drink_it/core/utils/json_codable.dart';

class Measure implements JsonCodable {
  final String? measure;
  final Ingredient ingredient;

  Measure({
    required this.measure,
    required this.ingredient,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'measure': measure,
      'ingredient': ingredient.toJson(),
    };
  }

  static Measure fromJson(Map<String, dynamic> json) {
    return Measure(
      measure: json['measure'],
      ingredient: Ingredient.fromJson(json['ingredient']),
    );
  }
}
