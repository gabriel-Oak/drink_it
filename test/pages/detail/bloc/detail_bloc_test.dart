import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:drink_it/core/features/cocktail/cocktail_errors.dart';
import 'package:drink_it/core/features/cocktail/datasources/errors.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/pages/detail/bloc/detail_bloc.dart';
import 'package:drink_it/pages/detail/bloc/detail_event.dart';
import 'package:drink_it/pages/detail/bloc/detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../core/features/cocktail/cocktail.mock.dart';

class MockGetDetails extends Mock implements GetDetails {}

void main() {
  final mockGetDetails = MockGetDetails();
  final shallowCocktailMock = ShallowCocktail.fromJson(cocktailJsonMock);
  final cocktailMock = CocktailV2.fromJson(cocktailJsonMock);

  build() => DetailBloc(getDetails: mockGetDetails);

  group('DetailBloc Tests', () {
    group('DetailStarted', () {
      blocTest(
        'should handle DetailStarted successfully',
        build: build,
        act: (bloc) => bloc.add(DetailStarted(cocktail: shallowCocktailMock)),
        setUp: () {
          when(() => mockGetDetails('15346')).thenAnswer((_) async =>
              Right<FailureGetCocktails, CocktailV2>(cocktailMock));
        },
        expect: () => [
          DetailLoading(cocktail: shallowCocktailMock),
          DetailLoaded(cocktail: cocktailMock),
        ],
      );

      blocTest(
        'should handle DetailStarted with FailureGetCocktails',
        build: build,
        act: (bloc) => bloc.add(DetailStarted(cocktail: shallowCocktailMock)),
        setUp: () {
          when(() => mockGetDetails('15346')).thenAnswer((_) async =>
              Left<FailureGetCocktails, CocktailV2>(DatasourceError()));
        },
        skip: 1,
        expect: () => [
          DetailLoadingFailed(
            cocktail: shallowCocktailMock,
            message:
                'Sorry, something wen wrong searching for your cocktails, stay sober :(',
          )
        ],
      );
    });
  });
}
