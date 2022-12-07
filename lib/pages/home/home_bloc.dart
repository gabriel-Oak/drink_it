// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/pages/home/home_event.dart';
import 'package:drink_it/pages/home/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetDetails getDetails;
  final SearchByAlcoholic searchByAlcoholic;
  final SearchByCategory searchByCategory;
  final SearchByIngredients searchByIngredient;
  final LookupRandom lookupRandom;

  HomeBloc({
    required this.getDetails,
    required this.searchByAlcoholic,
    required this.searchByCategory,
    required this.searchByIngredient,
    required this.lookupRandom,
  }) : super((HomeState())) {
    on<SearchByIngredientEvent>((event, emit) async {
      if (state is! LoadingList) {
        emit(LoadingList(
          searchMode: SearchMode.ingredients,
          selectedFilter: event.ingredient,
        ));

        final random = (await lookupRandom()).fold(id, id);
        final response =
            (await searchByIngredient(event.ingredient)).fold(id, id);

        if (response is List<CocktailItem>) {
          final prevState = Loaded(
            list: response,
            cocktailsInfo: const {},
            searchMode: SearchMode.ingredients,
            selectedFilter: event.ingredient,
            randomLookup: random is Cocktail ? random : null,
            message: random is FailureGetCocktails ? random.message : null,
          );
          emit(await _getDetails(response, prevState));
        } else {
          emit(ErrorState(
            message: response.toString(),
            searchMode: SearchMode.ingredients,
            selectedFilter: event.ingredient,
            randomLookup: random is Cocktail ? random : null,
          ));
        }
      }
    });

    on<SearchByCategoryEvent>((event, emit) async {
      if (state is! LoadingList) {
        emit(LoadingList(
          searchMode: SearchMode.category,
          selectedFilter: event.category,
        ));

        final random = (await lookupRandom()).fold(id, id);
        final response = (await searchByCategory(event.category)).fold(id, id);
        if (response is List<CocktailItem>) {
          final prevState = Loaded(
            list: response,
            cocktailsInfo: const {},
            searchMode: SearchMode.category,
            selectedFilter: event.category,
            randomLookup: random is Cocktail ? random : null,
            message: random is FailureGetCocktails ? random.message : null,
          );
          emit(await _getDetails(response, prevState));
        } else {
          emit(ErrorState(
            message: response.toString(),
            searchMode: SearchMode.category,
            selectedFilter: event.category,
            randomLookup: random is Cocktail ? random : null,
          ));
        }
      }
    });

    on<SearchByAlcoholicEvent>((event, emit) async {
      if (state is! LoadingList) {
        emit(LoadingList(
          searchMode: SearchMode.alcoholic,
          selectedFilter: event.alcoholic,
        ));

        final random = (await lookupRandom()).fold(id, id);
        final response =
            (await searchByAlcoholic(event.alcoholic)).fold(id, id);
        if (response is List<CocktailItem>) {
          final prevState = Loaded(
            list: response,
            cocktailsInfo: const {},
            searchMode: SearchMode.alcoholic,
            selectedFilter: event.alcoholic,
            randomLookup: random is Cocktail ? random : null,
            message: random is FailureGetCocktails ? random.message : null,
          );
          emit(await _getDetails(response, prevState));
        } else {
          emit(ErrorState(
            message: response.toString(),
            searchMode: SearchMode.alcoholic,
            selectedFilter: event.alcoholic,
            randomLookup: random is Cocktail ? random : null,
          ));
        }
      }
    });
  }

  Future<Loaded> _getDetails(
    List<CocktailItem> items,
    Loaded prevState,
  ) async {
    final previousLoadings = Map<String, bool?>.from(prevState.loadingInfo);
    final previousInfos = Map<String, Cocktail>.from(prevState.cocktailsInfo);

    for (var element in items) {
      final response = (await getDetails(element.id)).fold(id, id);
      if (response is Cocktail) {
        previousLoadings[element.id] = false;
        previousInfos[element.id] = response;
      }
    }

    return prevState.copyWith(
      cocktailsInfo: previousInfos,
      loadingInfo: previousLoadings,
    );
  }
}
