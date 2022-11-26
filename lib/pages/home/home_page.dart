import 'package:drink_it/pages/home/home_bloc.dart';
import 'package:drink_it/pages/home/home_content.dart';
import 'package:drink_it/pages/home/home_event.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(
        getDetails: getDetails,
        searchByAlcoholic: searchByAlcoholic,
        searchByCategory: searchByCategory,
        searchByIngredient: searchByIngredient,
      )..add(SearchByIngredientEvent('vodka')),
      child: const HomeContent(),
    );
  }
}
