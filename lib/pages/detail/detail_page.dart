import 'package:drink_it/core/container.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/features/cocktail/usecases/get_details.dart';
import 'package:drink_it/pages/detail/bloc/detail_bloc.dart';
import 'package:drink_it/pages/detail/bloc/detail_event.dart';
import 'package:drink_it/pages/detail/detail_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  final ShallowCocktail cocktail;
  const DetailPage({super.key, required this.cocktail});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailBloc>(
      create: (context) => DetailBloc(getDetails: container<GetDetails>())
        ..add(DetailStarted(cocktail: cocktail)),
      child: const DetailContent(),
    );
  }
}
