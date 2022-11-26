import 'package:drink_it/pages/home/home_bloc.dart';
import 'package:drink_it/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Hello Jhon'),
          ),
          body: SingleChildScrollView(
            child: Container(),
          ),
        );
      });
}
