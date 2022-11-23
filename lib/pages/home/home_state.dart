import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingList extends HomeState {}

class Loaded extends HomeState {
  final List<CocktailItem> list;
  final Map<String, Cocktail?> cocktailsInfo;
  final Map<String, bool?> loadingInfo;

  Loaded({
    required this.list,
    required this.cocktailsInfo,
    this.loadingInfo = const {},
  });

  Loaded copyWith({
    List<CocktailItem>? list,
    Map<String, Cocktail?>? cocktailsInfo,
    Map<String, bool?>? loadingInfo,
  }) {
    return Loaded(
      list: list ?? this.list,
      cocktailsInfo: cocktailsInfo ?? this.cocktailsInfo,
      loadingInfo: loadingInfo ?? this.loadingInfo,
    );
  }

  @override
  List<Object?> get props => [list, cocktailsInfo, loadingInfo];
}

class ErrorState extends HomeState {
  final String? message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
