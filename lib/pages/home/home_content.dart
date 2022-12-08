import 'package:drink_it/core/widgets/build_appbar.dart';
import 'package:drink_it/core/widgets/nav_bar.dart';
import 'package:drink_it/pages/home/bloc/home_bloc.dart';
import 'package:drink_it/pages/home/bloc/home_event.dart';
import 'package:drink_it/pages/home/bloc/home_state.dart';
import 'package:drink_it/pages/home/widgets/home_random.dart';
import 'package:drink_it/pages/home/widgets/home_list_cocktails.dart';
import 'package:drink_it/pages/home/widgets/home_list_skeleton.dart';
import 'package:drink_it/pages/home/widgets/home_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        if ((state is Loaded || state is ErrorState) &&
            (state as dynamic).message != null) {
          final snackBar = SnackBar(content: Text((state as dynamic).message));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

        if (state is! ErrorState && state is! Loaded && state is! LoadingList) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Scaffold(
          appBar: buildAppBar(context),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  RotatedBox(
                    quarterTurns: 135,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                        'Discovery',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      height: 200,
                      padding: const EdgeInsets.only(
                        right: 16,
                        top: 16,
                        bottom: 16,
                        left: 2,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: const HomeRandom(),
                      ),
                    ),
                  ),
                ],
              ),
              HomeSearchBar(
                searchMode: _getMode(state),
                selectedFilter: _getSelectedFilter(state),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RotatedBox(
                          quarterTurns: 135,
                          child: GestureDetector(
                            onTap: () {
                              if (_getMode(state) != SearchMode.ingredients) {
                                _searchIngredients(context, 'vodka');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              child: Text(
                                'Ingredients',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color:
                                      _getMode(state) == SearchMode.ingredients
                                          ? Colors.red[400]
                                          : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 135,
                          child: GestureDetector(
                            onTap: () {
                              if (_getMode(state) != SearchMode.category) {
                                _searchCategory(context, 'cocktail');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              child: Text(
                                'Category',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: _getMode(state) == SearchMode.category
                                      ? Colors.red[400]
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 135,
                          child: GestureDetector(
                            onTap: () {
                              if (_getMode(state) != SearchMode.alcoholic) {
                                _searchAlcoholic(context, 'alcoholic');
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 24,
                              ),
                              child: Text(
                                'Alcoholic',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: _getMode(state) == SearchMode.alcoholic
                                      ? Colors.red[400]
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        child: state is LoadingList
                            ? const HomeListSkeleton()
                            : state is Loaded
                                ? HomeListCocktails(
                                    info: (state).cocktailsInfo,
                                    list: (state).list,
                                  )
                                : Center(
                                    child: Text((state as ErrorState).message),
                                  ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          bottomNavigationBar: const NavBar(currentIndex: 0),
        );
      });

  _searchIngredients(BuildContext context, String ingredient) {
    BlocProvider.of<HomeBloc>(context).add(SearchByIngredientEvent(ingredient));
  }

  _searchCategory(BuildContext context, String category) {
    BlocProvider.of<HomeBloc>(context).add(SearchByCategoryEvent(category));
  }

  _searchAlcoholic(BuildContext context, String alcoholic) {
    BlocProvider.of<HomeBloc>(context).add(SearchByAlcoholicEvent(alcoholic));
  }

  SearchMode _getMode(HomeState state) {
    if (state is Loaded) return state.searchMode;
    if (state is LoadingList) return state.searchMode;
    if (state is ErrorState) return state.searchMode;
    return SearchMode.ingredients;
  }

  String? _getSelectedFilter(HomeState state) {
    if (state is Loaded) return state.selectedFilter;
    if (state is LoadingList) return state.selectedFilter;
    if (state is ErrorState) return state.selectedFilter;
    return null;
  }
}
