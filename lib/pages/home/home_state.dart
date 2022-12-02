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

  Loaded({
    required this.list,
    required this.cocktailsInfo,
    required this.searchMode,
    required this.selectedFilter,
    this.loadingInfo = const {},
  });

  Loaded copyWith({
    List<CocktailItem>? list,
    Map<String, Cocktail?>? cocktailsInfo,
    Map<String, bool?>? loadingInfo,
    SearchMode? searchMode,
    String? selectedFilter,
  }) {
    return Loaded(
        list: list ?? this.list,
        cocktailsInfo: cocktailsInfo ?? this.cocktailsInfo,
        loadingInfo: loadingInfo ?? this.loadingInfo,
        searchMode: searchMode ?? this.searchMode,
        selectedFilter: selectedFilter ?? this.selectedFilter);
  }

  @override
  List<Object?> get props => [list, cocktailsInfo, loadingInfo, selectedFilter];
}

class ErrorState extends HomeState {
  final String? message;
  final SearchMode searchMode;
  final String selectedFilter;

  ErrorState({
    required this.searchMode,
    required this.selectedFilter,
    this.message,
  });

  @override
  List<Object?> get props => [message, searchMode, selectedFilter];
}
