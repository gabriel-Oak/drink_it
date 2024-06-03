import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';

abstract class DetailEvent {}

class DetailStarted extends DetailEvent {
  final ShallowCocktail cocktail;

  DetailStarted({required this.cocktail});
}
