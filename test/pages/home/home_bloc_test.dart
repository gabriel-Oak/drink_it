import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/pages/home/bloc/home_bloc.dart';
import 'package:drink_it/pages/home/bloc/home_event.dart';
import 'package:drink_it/pages/home/bloc/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../core/features/cocktail/cocktails_search_mocks.dart';
import 'home_bloc_test.mocks.dart';

@GenerateMocks([
  SearchByIngredients,
  SearchByAlcoholic,
  SearchByCategory,
  GetDetails,
  LookupRandom,
])
void main() {
  final cocktailMap = (jsonDecode(cocktailsSearchMock)['drinks'] as List).first;
  final cocktailsList = [CocktailItem.fromMap(cocktailMap)];
  final cocktailInfo = Cocktail.fromMap(cocktailMap);

  final searchByIngredients = MockSearchByIngredients();
  final searchByAlcoholic = MockSearchByAlcoholic();
  final searchByCategory = MockSearchByCategory();
  final getDetails = MockGetDetails();
  final lookupRandom = MockLookupRandom();

  group('CounterBloc', () {
    late HomeBloc bloc;

    setUp(() {
      when(searchByIngredients('vodka'))
          .thenAnswer((_) async => Right(cocktailsList));
      when(searchByCategory('beer'))
          .thenAnswer((_) async => Right(cocktailsList));
      when(searchByAlcoholic('alcoholic'))
          .thenAnswer((_) async => Right(cocktailsList));
      when(getDetails('11007')).thenAnswer((_) async => Right(cocktailInfo));
      when(lookupRandom()).thenAnswer((_) async => Right(cocktailInfo));

      bloc = HomeBloc(
        getDetails: getDetails,
        searchByAlcoholic: searchByAlcoholic,
        searchByCategory: searchByCategory,
        searchByIngredient: searchByIngredients,
        lookupRandom: lookupRandom,
      );
    });

    test('initial state is HomeState', () {
      expect(bloc.state, isA<HomeState>());
    });

    blocTest<HomeBloc, HomeState>(
      'Should search by ingredients',
      build: () => bloc,
      act: (bloc) => bloc.add(SearchByIngredientEvent('vodka')),
      expect: () => [
        LoadingList(
          searchMode: SearchMode.ingredients,
          selectedFilter: 'vodka',
        ),
        Loaded(
          list: cocktailsList,
          cocktailsInfo: {'11007': cocktailInfo},
          loadingInfo: const {'11007': false},
          searchMode: SearchMode.ingredients,
          selectedFilter: 'vodka',
          randomLookup: cocktailInfo,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Should search by category',
      build: () => bloc,
      act: (bloc) => bloc.add(SearchByCategoryEvent('beer')),
      expect: () => [
        LoadingList(
          searchMode: SearchMode.category,
          selectedFilter: 'beer',
        ),
        Loaded(
          list: cocktailsList,
          cocktailsInfo: {'11007': cocktailInfo},
          loadingInfo: const {'11007': false},
          searchMode: SearchMode.category,
          selectedFilter: 'beer',
          randomLookup: cocktailInfo,
        ),
      ],
    );

    blocTest<HomeBloc, HomeState>(
      'Should search by alcoholic',
      build: () => bloc,
      act: (bloc) => bloc.add(SearchByAlcoholicEvent('alcoholic')),
      expect: () => [
        LoadingList(
          searchMode: SearchMode.alcoholic,
          selectedFilter: 'alcoholic',
        ),
        Loaded(
          list: cocktailsList,
          cocktailsInfo: {'11007': cocktailInfo},
          loadingInfo: const {'11007': false},
          searchMode: SearchMode.alcoholic,
          selectedFilter: 'alcoholic',
          randomLookup: cocktailInfo,
        ),
      ],
    );
  });
}
