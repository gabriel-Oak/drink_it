import 'package:drink_it/core/features/cocktail/entities/measure.dart';
import 'package:drink_it/core/utils/json_codable.dart';

class ShallowCocktail implements JsonCodable {
  final String id;
  final String name;
  final String thumb;
  final String category;
  final List<Measure> measures;

  ShallowCocktail({
    required this.id,
    required this.name,
    required this.thumb,
    required this.category,
    required this.measures,
  });

  @override
  toJson() {
    return {
      'id': id,
      'name': name,
      'thumb': thumb,
      'category': category,
      'measures': measures.map((e) => e.toJson()),
    };
  }

  static ShallowCocktail fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> measuresJson = json['measures'];
    return ShallowCocktail(
      id: json['id'],
      name: json['name'],
      thumb: json['thumb'],
      category: json['category'],
      measures: measuresJson.map(Measure.fromJson).toList(),
    );
  }
}
