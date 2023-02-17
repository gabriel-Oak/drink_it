import 'package:drink_it/core/features/cocktail/models/ingredient.dart';
import 'package:drink_it/core/features/cocktail/models/measure.dart';

class Cocktail {
  final String id;
  final String name;
  final String thumb;
  final String alcoholic;
  final String glass;
  final List<Measure> measures;
  final String? category;
  final String? video;
  final String? tags;
  final String? instructions;
  final String? instructionsES;
  final String? instructionsDE;
  final String? instructionsFR;
  final String? instructionsIT;
  final String? instructionsPtBR;
  final String? dateModified;
  final String? iba;

  Cocktail({
    required this.id,
    required this.name,
    required this.thumb,
    required this.alcoholic,
    required this.glass,
    required this.measures,
    this.category,
    this.video,
    this.tags,
    this.instructions,
    this.instructionsES,
    this.instructionsDE,
    this.instructionsFR,
    this.instructionsIT,
    this.instructionsPtBR,
    this.dateModified,
    this.iba,
  });

  static Cocktail fromMap(Map<String, dynamic> map) {
    // final List<Ingredient> measures = (map['measures'] as List<Map<String, dynamic>>).map((key, value) => null);
    return Cocktail(
      id: map['id'],
      name: map['name'],
      thumb: map['thumb'],
      tags: map['tags'],
      category: map['category'],
      alcoholic: map['alcoholic'],
      glass: map['glass'],
      video: map['video'],
      instructions: map['instructions'],
      instructionsES: map['instructionsES'],
      instructionsDE: map['instructionsDE'],
      instructionsFR: map['instructionsFR'],
      instructionsIT: map['instructionsIT'],
      instructionsPtBR: map['instructionsPtBR'],
      dateModified: map['dateModified'],
      iba: map['iba'],
    );
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = {
      'idDrink': id,
      'strDrink': name,
      'strDrinkThumb': thumb,
      'strTags': tags,
      'strCategory': category,
      'strAlcoholic': alcoholic,
      'strGlass': glass,
      'strVideo': video,
      'strInstructions': instructions,
      'strInstructionsES': instructionsES,
      'strInstructionsDE': instructionsDE,
      'strInstructionsFR': instructionsFR,
      'strInstructionsIT': instructionsIT,
      'dateModified': dateModified,
      'strIBA': iba,
    };

    for (var i = 1; i <= 15; i++) {
      final isInRange = measures.length > i;
      map['strIngredient$i'] = isInRange ? ingredients[i - 1].name : null;
      map['strMeasure$i'] = isInRange ? ingredients[i - 1].measure : null;
    }

    return map;
  }
}
