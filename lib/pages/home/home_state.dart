import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:equatable/equatable.dart';

enum SearchMode {
  ingredients,
  category,
  alcoholic,
}

class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingList extends HomeState {
  final SearchMode searchMode;

  LoadingList({
    required this.searchMode,
  });

  @override
  List<Object?> get props => [searchMode];
}

class Loaded extends HomeState {
  final List<CocktailItem> list;
  final Map<String, Cocktail?> cocktailsInfo;
  final Map<String, bool?> loadingInfo;
  final SearchMode searchMode;

  Loaded({
    required this.list,
    required this.cocktailsInfo,
    required this.searchMode,
    this.loadingInfo = const {},
  });

  Loaded copyWith({
    List<CocktailItem>? list,
    Map<String, Cocktail?>? cocktailsInfo,
    Map<String, bool?>? loadingInfo,
    SearchMode? searchMode,
  }) {
    return Loaded(
      list: list ?? this.list,
      cocktailsInfo: cocktailsInfo ?? this.cocktailsInfo,
      loadingInfo: loadingInfo ?? this.loadingInfo,
      searchMode: searchMode ?? this.searchMode,
    );
  }

  @override
  List<Object?> get props => [list, cocktailsInfo, loadingInfo];
}

class ErrorState extends HomeState {
  final String? message;
  final SearchMode searchMode;

  ErrorState({required this.searchMode, this.message});

  @override
  List<Object?> get props => [message, searchMode];
}
