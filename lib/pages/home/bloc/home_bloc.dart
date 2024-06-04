// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/pages/home/bloc/home_event.dart';
import 'package:drink_it/pages/home/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SearchByAlcoholic searchByAlcoholic;
  final SearchByCategory searchByCategory;
  final SearchByIngredients searchByIngredient;
  final LookupRandom lookupRandom;

  HomeBloc({
    required this.searchByAlcoholic,
    required this.searchByCategory,
    required this.searchByIngredient,
    required this.lookupRandom,
  }) : super((HomeState())) {
    on<SearchByIngredientEvent>(_searchByIngredients);
    on<SearchByCategoryEvent>(_searchByCategory);
    on<SearchByAlcoholicEvent>(_searchByAlcoholic);
  }

  _searchByIngredients(
    SearchByIngredientEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is LoadingList) return;

    emit(LoadingList(
      searchMode: SearchMode.ingredients,
      selectedFilter: event.ingredient,
    ));

    final [randomResponse, cocktailsResponse] = await Future.wait([
      lookupRandom(),
      searchByIngredient(event.ingredient),
    ]);

    final random = randomResponse.fold(id, id);
    final response = cocktailsResponse.fold(id, id);

    emit(_buildLoadedOrError(
      list: response,
      searchMode: SearchMode.ingredients,
      selectedFilter: event.ingredient,
      randomLookup: random,
    ));
  }

  _searchByCategory(
    SearchByCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is LoadingList) return;

    emit(LoadingList(
      searchMode: SearchMode.category,
      selectedFilter: event.category,
    ));

    final [randomResponse, cocktailsResponse] = await Future.wait([
      lookupRandom(),
      searchByCategory(event.category),
    ]);

    final random = randomResponse.fold(id, id);
    final response = cocktailsResponse.fold(id, id);

    emit(_buildLoadedOrError(
      list: response,
      searchMode: SearchMode.category,
      selectedFilter: event.category,
      randomLookup: random,
    ));
  }

  _searchByAlcoholic(
    SearchByAlcoholicEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is LoadingList) return;

    emit(LoadingList(
      searchMode: SearchMode.alcoholic,
      selectedFilter: event.alcoholic,
    ));

    final [randomResponse, cocktailsResponse] = await Future.wait([
      lookupRandom(),
      searchByAlcoholic(event.alcoholic),
    ]);

    final random = randomResponse.fold(id, id);
    final response = cocktailsResponse.fold(id, id);

    emit(_buildLoadedOrError(
      list: response,
      searchMode: SearchMode.alcoholic,
      selectedFilter: event.alcoholic,
      randomLookup: random,
    ));
  }

  _buildLoadedOrError({
    required Object list,
    required SearchMode searchMode,
    required String selectedFilter,
    dynamic randomLookup,
  }) {
    if (list is List<ShallowCocktail>) {
      return Loaded(
        list: list,
        searchMode: searchMode,
        selectedFilter: selectedFilter,
        randomLookup: randomLookup is ShallowCocktail ? randomLookup : null,
        message:
            randomLookup is FailureGetCocktails ? randomLookup.message : null,
      );
    }

    return ErrorState(
      message: (list as FailureGetCocktails).toString(),
      searchMode: searchMode,
      selectedFilter: selectedFilter,
      randomLookup: randomLookup is ShallowCocktail ? randomLookup : null,
    );
  }
}
