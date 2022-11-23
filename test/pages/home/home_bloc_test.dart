import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_alcoholic.dart';
import 'package:drink_it/core/features/cocktail/usecases/seach_by_ingredient.dart';
import 'package:drink_it/core/features/cocktail/usecases/search_by_category.dart';
import 'package:drink_it/pages/home/home_bloc.dart';
import 'package:drink_it/pages/home/home_event.dart';
import 'package:drink_it/pages/home/home_state.dart';
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
])
void main() {
  final cocktailMap = (jsonDecode(cocktailsSearchMock)['drinks'] as List).first;
  final cocktailsList = [CocktailItem.fromMap(cocktailMap)];
  final cocktailInfo = Cocktail.fromMap(cocktailMap);

  final searchByIngredients = MockSearchByIngredients();
  final searchByAlcoholic = MockSearchByAlcoholic();
  final searchByCategory = MockSearchByCategory();
  final getDetails = MockGetDetails();

  // final bloc = HomeBloc(
  //   getDetails: getDetails,
  //   searchByAlcoholic: searchByAlcoholic,
  //   searchByCategory: searchByCategory,
  //   searchByIngredient: searchByIngredients,
  // );

  group('CounterBloc', () {
    late HomeBloc bloc;

    setUp(() {
      when(searchByIngredients.call('vodka'))
          .thenAnswer((_) async => Right(cocktailsList));
      when(getDetails.call('11007'))
          .thenAnswer((_) async => Right(cocktailInfo));

      bloc = HomeBloc(
        getDetails: getDetails,
        searchByAlcoholic: searchByAlcoholic,
        searchByCategory: searchByCategory,
        searchByIngredient: searchByIngredients,
      );
    });

    test('initial state is HomeState', () {
      expect(bloc.state, isA<HomeState>());
    });

    blocTest<HomeBloc, HomeState>(
      'emits should search by ingredients',
      build: () => bloc,
      act: (bloc) => bloc.add(SearchByIngredientEvent('vodka')),
      expect: () => [
        LoadingList(),
        Loaded(
          list: cocktailsList,
          cocktailsInfo: const {},
          loadingInfo: const {},
        ),
        Loaded(
          list: cocktailsList,
          cocktailsInfo: const {},
          loadingInfo: const {'11007': true},
        ),
        Loaded(
          list: cocktailsList,
          cocktailsInfo: {'11007': cocktailInfo},
          loadingInfo: const {'11007': false},
        ),
      ],
    );
  });
}
