import 'package:drink_it/pages/main/bloc/main_bloc.dart';
import 'package:drink_it/pages/main/main_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainBloc>(
      create: (context) => MainBloc(),
      child: const MainContent(),
    );
  }
}
