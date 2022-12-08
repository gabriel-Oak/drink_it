import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';

abstract class DetailEvent {}

class DetailStarted extends DetailEvent {
  final Cocktail cocktail;

  DetailStarted({required this.cocktail});
}
