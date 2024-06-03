import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
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
  final List<ShallowCocktail> list;
  final SearchMode searchMode;
  final String selectedFilter;
  final ShallowCocktail? randomLookup;
  final String? message;

  Loaded({
    required this.list,
    required this.searchMode,
    required this.selectedFilter,
    this.randomLookup,
    this.message,
  });

  Loaded copyWith({
    List<ShallowCocktail>? list,
    SearchMode? searchMode,
    String? selectedFilter,
    ShallowCocktail? randomLookup,
    String? message,
  }) =>
      Loaded(
        list: list ?? this.list,
        searchMode: searchMode ?? this.searchMode,
        selectedFilter: selectedFilter ?? this.selectedFilter,
        randomLookup: randomLookup ?? this.randomLookup,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        list,
        selectedFilter,
        randomLookup,
        message,
      ];
}

class ErrorState extends HomeState {
  final String message;
  final SearchMode searchMode;
  final String selectedFilter;
  final ShallowCocktail? randomLookup;

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
