import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/features/cocktail/usecases/lookup_random.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/pages/home/bloc/home_bloc.dart';
import 'package:drink_it/pages/home/bloc/home_event.dart';
import 'package:drink_it/pages/home/bloc/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/features/cocktail/cocktail.mock.dart';

class MockGetDetails extends Mock implements GetDetails {}

class MockSearchByAlcoholic extends Mock implements SearchByAlcoholic {}

class MockSearchByCategory extends Mock implements SearchByCategory {}

class MockSearchByIngredients extends Mock implements SearchByIngredients {}

class MockLookupRandom extends Mock implements LookupRandom {}

void main() {
  final getDetailsMock = MockGetDetails();
  final searchByAlcoholicMock = MockSearchByAlcoholic();
  final searchByCategoryMock = MockSearchByCategory();
  final searchByIngredientMock = MockSearchByIngredients();
  final lookupRandomMock = MockLookupRandom();
  final shallowCocktailMock = ShallowCocktail.fromJson(cocktailJsonMock);

  build() => HomeBloc(
        getDetails: getDetailsMock,
        searchByAlcoholic: searchByAlcoholicMock,
        searchByCategory: searchByCategoryMock,
        searchByIngredient: searchByIngredientMock,
        lookupRandom: lookupRandomMock,
      );

  group('HomeBloc Tests', () {
    group('SearchByIngredientEvent', () {
      blocTest(
        'should handle SearchByIngredientEvent successfully',
        build: build,
        act: (bloc) => bloc.add(SearchByIngredientEvent('vodka')),
        setUp: () {
          when(() => searchByIngredientMock('vodka')).thenAnswer((_) async =>
              Right<FailureGetCocktails, List<ShallowCocktail>>(
                  [shallowCocktailMock]));

          when(() => lookupRandomMock()).thenAnswer((_) async =>
              Right<FailureGetCocktails, ShallowCocktail>(shallowCocktailMock));
        },
        expect: () => [
          LoadingList(
            searchMode: SearchMode.ingredients,
            selectedFilter: 'vodka',
          ),
          Loaded(
            list: [shallowCocktailMock],
            searchMode: SearchMode.ingredients,
            selectedFilter: 'vodka',
            randomLookup: shallowCocktailMock,
          ),
        ],
      );

      blocTest(
        'should handle SearchByIngredientEvent with FailureGetCocktails',
        build: build,
        act: (bloc) => bloc.add(SearchByIngredientEvent('vodka')),
        setUp: () {
          when(() => searchByIngredientMock('vodka')).thenAnswer((_) async =>
              Left<FailureGetCocktails, List<ShallowCocktail>>(
                  DatasourceError()));

          when(() => lookupRandomMock()).thenAnswer((_) async =>
              Right<FailureGetCocktails, ShallowCocktail>(shallowCocktailMock));
        },
        skip: 1,
        expect: () => [
          ErrorState(
            message:
                'Sorry, something wen wrong searching for your cocktails, stay sober :(',
            searchMode: SearchMode.ingredients,
            selectedFilter: 'vodka',
            randomLookup: shallowCocktailMock,
          ),
        ],
      );
    });

    group('SearchByCategoryEvent', () {
      blocTest(
        'should handle SearchByCategoryEvent successfully',
        build: build,
        act: (bloc) => bloc.add(SearchByCategoryEvent('punch')),
        setUp: () {
          when(() => searchByCategoryMock('punch')).thenAnswer((_) async =>
              Right<FailureGetCocktails, List<ShallowCocktail>>(
                  [shallowCocktailMock]));

          when(() => lookupRandomMock()).thenAnswer((_) async =>
              Right<FailureGetCocktails, ShallowCocktail>(shallowCocktailMock));
        },
        expect: () => [
          LoadingList(
            searchMode: SearchMode.category,
            selectedFilter: 'punch',
          ),
          Loaded(
            list: [shallowCocktailMock],
            searchMode: SearchMode.category,
            selectedFilter: 'punch',
            randomLookup: shallowCocktailMock,
          ),
        ],
      );

      blocTest(
        'should handle SearchByCategoryEvent with FailureGetCocktails',
        build: build,
        act: (bloc) => bloc.add(SearchByCategoryEvent('punch')),
        setUp: () {
          when(() => searchByCategoryMock('punch')).thenAnswer((_) async =>
              Left<FailureGetCocktails, List<ShallowCocktail>>(
                  DatasourceError()));

          when(() => lookupRandomMock()).thenAnswer((_) async =>
              Right<FailureGetCocktails, ShallowCocktail>(shallowCocktailMock));
        },
        skip: 1,
        expect: () => [
          ErrorState(
            message:
                'Sorry, something wen wrong searching for your cocktails, stay sober :(',
            searchMode: SearchMode.category,
            selectedFilter: 'punch',
            randomLookup: shallowCocktailMock,
          ),
        ],
      );
    });
  });

  group('SearchByAlcoholicEvent', () {
    blocTest(
      'should handle SearchByAlcoholicEvent successfully',
      build: build,
      act: (bloc) => bloc.add(SearchByAlcoholicEvent('alcoholic')),
      setUp: () {
        when(() => searchByAlcoholicMock('alcoholic')).thenAnswer((_) async =>
            Right<FailureGetCocktails, List<ShallowCocktail>>(
                [shallowCocktailMock]));

        when(() => lookupRandomMock()).thenAnswer((_) async =>
            Right<FailureGetCocktails, ShallowCocktail>(shallowCocktailMock));
      },
      expect: () => [
        LoadingList(
          searchMode: SearchMode.alcoholic,
          selectedFilter: 'alcoholic',
        ),
        Loaded(
          list: [shallowCocktailMock],
          searchMode: SearchMode.alcoholic,
          selectedFilter: 'alcoholic',
          randomLookup: shallowCocktailMock,
        ),
      ],
    );

    blocTest(
      'should handle SearchByAlcoholicEvent with FailureGetCocktails',
      build: build,
      act: (bloc) => bloc.add(SearchByAlcoholicEvent('alcoholic')),
      setUp: () {
        when(() => searchByAlcoholicMock('alcoholic')).thenAnswer((_) async =>
            Left<FailureGetCocktails, List<ShallowCocktail>>(
                DatasourceError()));

        when(() => lookupRandomMock()).thenAnswer((_) async =>
            Right<FailureGetCocktails, ShallowCocktail>(shallowCocktailMock));
      },
      skip: 1,
      expect: () => [
        ErrorState(
          message:
              'Sorry, something wen wrong searching for your cocktails, stay sober :(',
          searchMode: SearchMode.alcoholic,
          selectedFilter: 'alcoholic',
          randomLookup: shallowCocktailMock,
        ),
      ],
    );
  });
}
