import 'package:drink_it/core/features/cocktail/models/ingredient_model.dart';

class Cocktail {
  final String id;
  final String name;
  final String thumb;
  final String tags;
  final String category;
  final String alcoholic;
  final String glass;
  final String? instructions;
  final String? instructionsES;
  final String? instructionsDE;
  final String? instructionsFR;
  final String? instructionsIT;
  final List<Ingredient> ingredients;
  final String dateModified;

  Cocktail({
    required this.id,
    required this.name,
    required this.thumb,
    required this.tags,
    required this.category,
    required this.alcoholic,
    required this.glass,
    this.instructions,
    this.instructionsES,
    this.instructionsDE,
    this.instructionsFR,
    this.instructionsIT,
    required this.ingredients,
    required this.dateModified,
  });

  static Cocktail fromMap(Map<String, dynamic> map) {
    final List<Ingredient> ingredients = [];
    map.forEach((key, value) {
      if (key.contains('Ingredient') && map[key] != null) {
        ingredients.add(Ingredient(
          name: value,
          measure: map['strMeasure${key.split('Ingredient').last}'],
        ));
      }
    });

    return Cocktail(
      id: map['idDrink'],
      name: map['strDrink'],
      thumb: map['strDrinkThumb'],
      tags: map['strDrinkThumb'],
      category: map['strCategory'],
      alcoholic: map['strAlcoholic'],
      glass: map['strGlass'],
      instructions: map['strInstructions'],
      instructionsES: map['strInstructionsES'],
      instructionsDE: map['strInstructionsDE'],
      instructionsFR: map['strInstructionsFR'],
      instructionsIT: map['strInstructionsIT'],
      dateModified: map['dateModified'],
      ingredients: ingredients,
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
      'strInstructions': instructions,
      'strInstructionsES': instructionsES,
      'strInstructionsDE': instructionsDE,
      'strInstructionsFR': instructionsFR,
      'strInstructionsIT': instructionsIT,
      'dateModified': dateModified,
    };

    for (var i = 1; i <= 15; i++) {
      final isInRange = ingredients.length <= i;
      map['strIngredient$i'] = isInRange ? ingredients[i].name : null;
      map['strMeasure$i'] = isInRange ? ingredients[i].measure : null;
    }

    return map;
  }
}
