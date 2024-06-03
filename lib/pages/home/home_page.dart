import 'package:drink_it/pages/home/bloc/home_bloc.dart';
import 'package:drink_it/pages/home/bloc/home_event.dart';
import 'package:drink_it/pages/home/home_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) =>
          Modular.get<HomeBloc>()..add(SearchByIngredientEvent('vodka')),
      child: const HomeContent(),
    );
  }
}
