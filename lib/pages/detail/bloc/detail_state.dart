import 'package:drink_it/core/features/cocktail/models/cocktail.dart';
import 'package:equatable/equatable.dart';

class DetailState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class DetailLoaded extends DetailState {
  final Cocktail cocktail;

  DetailLoaded({required this.cocktail});

  @override
  List<Object?> get props => [cocktail];
}
