import 'package:cached_network_image/cached_network_image.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/pages/detail/detail_page.dart';
import 'package:drink_it/pages/home/bloc/home_bloc.dart';
import 'package:drink_it/pages/home/bloc/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class HomeRandom extends StatelessWidget {
  const HomeRandom({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
      if (state is LoadingList) {
        return const SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: double.infinity,
          ),
        );
      }

      if (state is Loaded) {
        return state.randomLookup != null
            ? _buildCard(context, state.randomLookup!)
            : const Center(
                child: Text('Sorry, we couldn\'t find your suggestion'),
              );
      }

      return Center(
        child: (state as ErrorState).randomLookup != null
            ? _buildCard(context, state.randomLookup!)
            : const Text('Sorry, we couldn\'t find your suggestion'),
      );
    });
  }

  Widget _buildCard(BuildContext context, ShallowCocktail cocktail) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailPage(cocktail: cocktail),
        ));
      },
      child: SizedBox(
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: '${cocktail.thumb}/preview',
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) => const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              errorWidget: (context, url, error) => const Center(
                child: Icon(
                  Icons.no_drinks,
                  color: Colors.black38,
                  size: 158,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white60,
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 4,
                    ),
                    constraints: BoxConstraints.loose(const Size(200, 200)),
                    child: Text(
                      cocktail.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 28,
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
                    constraints: BoxConstraints.loose(const Size(160, 200)),
                    child: Text(
                      cocktail.measures.isNotEmpty
                          ? cocktail.measures.first.ingredient.name
                          : 'Unknown',
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
                    constraints: BoxConstraints.loose(const Size(160, 200)),
                    child: Text(
                      cocktail.category,
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
    );
  }

  // _test(String url) async {
  //   try {
  //     final response = await Dio()
  //         .get(url, options: Options(responseType: ResponseType.bytes));
  //     final bytes = response.data as Uint8List;

  //     double colorSum = 0;

  //     for (int i = 0; i < bytes.length; i++) {
  //       int pixel = bytes[i];
  //       int b = (pixel & 0x00FF0000) >> 16;
  //       int g = (pixel & 0x0000FF00) >> 8;
  //       int r = (pixel & 0x000000FF);
  //       var avg = (r + g + b) / 3;
  //       colorSum += avg;
  //     }

  //     final brightness = colorSum / bytes.length;
  //     // 43 very dark, 40, very white image
  //     // TODO: foget it, get the main color of the image, then get colors luminance, set text background as color, ent text color black or white based on luminance
  //     print(brightness);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
