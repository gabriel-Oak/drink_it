import 'package:drink_it/core/features/cocktail/entities/measure.dart';
import 'package:drink_it/core/utils/json_codable.dart';

class CocktailV2 implements JsonCodable {
  final String id;
  final String name;
  final String thumb;
  final String alcoholic;
  final String glass;
  final String category;
  final String instructions;
  final String instructionsES;
  final String instructionsDE;
  final String instructionsFR;
  final String instructionsIT;
  final List<Measure> measures;

  CocktailV2({
    required this.id,
    required this.name,
    required this.thumb,
    required this.alcoholic,
    required this.glass,
    required this.category,
    required this.instructions,
    required this.instructionsES,
    required this.instructionsDE,
    required this.instructionsFR,
    required this.instructionsIT,
    required this.measures,
  });

  @override
  toJson() {
    return {
      'id': id,
      'name': name,
      'thumb': thumb,
      'alcoholic': alcoholic,
      'glass': glass,
      'category': category,
      'instructions': instructions,
      'instructionsES': instructionsES,
      'instructionsDE': instructionsDE,
      'instructionsFR': instructionsFR,
      'instructionsIT': instructionsIT,
      'measures': measures.map((e) => e.toJson()),
    };
  }

  static CocktailV2 fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>> measuresJson = json['measures'];
    return CocktailV2(
      id: json['id'],
      name: json['name'],
      thumb: json['thumb'],
      alcoholic: json['alcoholic'],
      glass: json['glass'],
      category: json['category'],
      instructions: json['instructions'],
      instructionsES: json['instructionsES'],
      instructionsDE: json['instructionsDE'],
      instructionsFR: json['instructionsFR'],
      instructionsIT: json['instructionsIT'],
      measures: measuresJson.map(Measure.fromJson).toList(),
    );
  }
}
