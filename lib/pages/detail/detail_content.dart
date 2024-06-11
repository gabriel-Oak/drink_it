import 'package:cached_network_image/cached_network_image.dart';
import 'package:drink_it/core/features/cocktail/entities/cocktail_v2.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/core/widgets/build_appbar.dart';
import 'package:drink_it/pages/detail/bloc/detail_bloc.dart';
import 'package:drink_it/pages/detail/bloc/detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class DetailContent extends StatelessWidget {
  const DetailContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(
      builder: (context, state) {
        return state is DetailInitialState
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: buildAppBar(
                  title: _getShallowCocktail(state)?.name,
                  context,
                  leading: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black54,
                    ),
                  ),
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  '${_getShallowCocktail(state)?.thumb}/preview',
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 220,
                              placeholder: (context, url) => SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Center(
                                child: Icon(
                                  Icons.no_drinks,
                                  color: Colors.black38,
                                  size: 200,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 18,
                              top: 18,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.white60,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 4,
                                    ),
                                    constraints: BoxConstraints.loose(
                                        const Size(220, 200)),
                                    child: Text(
                                      _getShallowCocktail(state)?.name ??
                                          'Unknown',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    color: Colors.white60,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 4,
                                    ),
                                    constraints: BoxConstraints.loose(
                                        const Size(160, 200)),
                                    child: Text(
                                      _getShallowCocktail(state)
                                              ?.measures
                                              .first
                                              .ingredient
                                              .name ??
                                          'Unknown',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    color: Colors.white60,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2,
                                      horizontal: 4,
                                    ),
                                    constraints: BoxConstraints.loose(
                                        const Size(160, 200)),
                                    child: Text(
                                      _getShallowCocktail(state)?.category ??
                                          'Unknown',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DefaultTabController(
                      length: 3,
                      child: Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                RotatedBox(
                                  quarterTurns: 135,
                                  child: GestureDetector(
                                    onTap: () =>
                                        DefaultTabController.of(context)
                                            .animateTo(0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 24,
                                      ),
                                      child: Text(
                                        'Instructions',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.red[400],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                RotatedBox(
                                  quarterTurns: 135,
                                  child: GestureDetector(
                                    onTap: () =>
                                        DefaultTabController.of(context)
                                            .animateTo(1),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 24,
                                      ),
                                      child: const Text(
                                        'Similar Cocktails',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                RotatedBox(
                                  quarterTurns: 135,
                                  child: GestureDetector(
                                    onTap: () =>
                                        DefaultTabController.of(context)
                                            .animateTo(2),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 24,
                                      ),
                                      child: const Text(
                                        'Reviews',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          _getCocktail(state)?.instructions ??
                                              'Unknown',
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            height: 1.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SingleChildScrollView(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Unknown 1',
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 18,
                                            height: 1.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SingleChildScrollView(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Unknown 2',
                                          softWrap: true,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 18,
                                            height: 1.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  ShallowCocktail? _getShallowCocktail(dynamic state) =>
      state is DetailLoadingFailed
          ? state.cocktail
          : state is DetailLoading
              ? state.cocktail
              : state is DetailLoaded
                  ? ShallowCocktail.fromJson(state.cocktail.toJson())
                  : null;

  CocktailV2? _getCocktail(dynamic state) =>
      state is DetailLoaded ? state.cocktail : null;
}
