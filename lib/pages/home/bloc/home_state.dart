import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail.dart';
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
  final String selectedFilter;

  LoadingList({
    required this.searchMode,
    required this.selectedFilter,
  });

  @override
  List<Object?> get props => [searchMode, selectedFilter];
}

class Loaded extends HomeState {
  final List<CocktailItem> list;
  final Map<String, Cocktail?> cocktailsInfo;
  final Map<String, bool?> loadingInfo;
  final SearchMode searchMode;
  final String selectedFilter;
  final Cocktail? randomLookup;
  final String? message;

  Loaded({
    required this.list,
    required this.cocktailsInfo,
    required this.searchMode,
    required this.selectedFilter,
    this.randomLookup,
    this.loadingInfo = const {},
    this.message,
  });

  Loaded copyWith({
    List<CocktailItem>? list,
    Map<String, Cocktail?>? cocktailsInfo,
    Map<String, bool?>? loadingInfo,
    SearchMode? searchMode,
    String? selectedFilter,
    Cocktail? randomLookup,
    String? message,
  }) =>
      Loaded(
        list: list ?? this.list,
        cocktailsInfo: cocktailsInfo ?? this.cocktailsInfo,
        loadingInfo: loadingInfo ?? this.loadingInfo,
        searchMode: searchMode ?? this.searchMode,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        randomLookup: randomLookup ?? this.randomLookup,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        list,
        cocktailsInfo,
        loadingInfo,
        selectedFilter,
        randomLookup,
        message,
      ];
}

class ErrorState extends HomeState {
  final String message;
  final SearchMode searchMode;
  final String selectedFilter;
  final Cocktail? randomLookup;

  ErrorState({
    required this.searchMode,
    required this.selectedFilter,
    required this.message,
    this.randomLookup,
  });

  @override
  List<Object?> get props =>
      [message, searchMode, selectedFilter, randomLookup];
}
