// ignore_for_file: public_member_api_docs, sort_constructors_first, depend_on_referenced_packages, invalid_use_of_visible_for_testing_member
import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
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

  HomeBloc({
    required this.getDetails,
    required this.searchByAlcoholic,
    required this.searchByCategory,
    required this.searchByIngredient,
  }) : super((HomeState())) {
    on<SearchByIngredientEvent>((event, emit) async {
      emit(LoadingList());
      final response =
          (await searchByIngredient(event.ingredient)).fold(id, id);
      if (response is List<CocktailItem>) {
        emit(Loaded(
          list: response,
          cocktailsInfo: const {},
          searchMode: SearchMode.ingredients,
        ));
        _getDetails(response);
      } else {
        emit(ErrorState(response.toString()));
      }
    });

    on<SearchByCategoryEvent>((event, emit) async {
      emit(LoadingList());
      final response = (await searchByCategory(event.category)).fold(id, id);
      if (response is List<CocktailItem>) {
        emit(Loaded(
          list: response,
          cocktailsInfo: const {},
          searchMode: SearchMode.category,
        ));
        _getDetails(response);
      } else {
        emit(ErrorState(response.toString()));
      }
    });

    on<SearchByAlcoholicEvent>((event, emit) async {
      emit(LoadingList());
      final response = (await searchByAlcoholic(event.alcoholic)).fold(id, id);
      if (response is List<CocktailItem>) {
        emit(Loaded(
          list: response,
          cocktailsInfo: const {},
          searchMode: SearchMode.category,
        ));
        _getDetails(response);
      } else {
        emit(ErrorState(response.toString()));
      }
    });
  }

  _getDetails(
    List<CocktailItem> items,
  ) async {
    final Map<String, bool?> loadings = {};
    for (var element in items) {
      loadings[element.id] = true;
    }
    emit((state as Loaded).copyWith(loadingInfo: loadings));

    for (var element in items) {
      final response = (await getDetails(element.id)).fold(id, id);
      if (response is Cocktail) {
        final previousLoadings =
            Map<String, bool?>.from((state as Loaded).loadingInfo);
        final previousInfos =
            Map<String, Cocktail>.from((state as Loaded).cocktailsInfo);
        previousLoadings[element.id] = false;
        previousInfos[element.id] = response;

        emit((state as Loaded).copyWith(
          cocktailsInfo: previousInfos,
          loadingInfo: previousLoadings,
        ));
      }
    }
  }
}
