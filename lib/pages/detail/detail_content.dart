import 'package:drink_it/core/widgets/build_appbar.dart';
import 'package:drink_it/pages/detail/bloc/detail_bloc.dart';
import 'package:drink_it/pages/detail/bloc/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        return Scaffold(
          appBar: buildAppBar(
            context,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black54,
              ),
            ),
          ),
          body: state is DetailLoaded
              ? SingleChildScrollView(
                  child: Column(
                    children: [Text(state.cocktail.name)],
                  ),
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
