import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:equatable/equatable.dart';

class DetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DetailLoading extends DetailState {
  final ShallowCocktail cocktail;

  DetailLoading({
    required this.cocktail,
  });

  @override
  List<Object?> get props => [cocktail];
}

class DetailLoaded extends DetailState {
  final CocktailV2 cocktail;

  DetailLoaded({required this.cocktail});

  @override
  List<Object?> get props => [cocktail];
}

class DetailLoadingFailed extends DetailState {
  final ShallowCocktail cocktail;
  final String message;

  DetailLoadingFailed({
    required this.cocktail,
    required this.message,
  });

  @override
  List<Object?> get props => [cocktail, message];
}
