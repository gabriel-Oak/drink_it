import 'package:cached_network_image/cached_network_image.dart';
import 'package:drink_it/core/features/cocktail/entities/shallow_cocktail.dart';
import 'package:drink_it/pages/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeListCocktails extends StatelessWidget {
  final List<ShallowCocktail> list;

  const HomeListCocktails({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.only(top: 4, right: 16, left: 4),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final cocktail = list[index];

              return Tooltip(
                message: cocktail.name,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    color: Colors.white,
                    surfaceTintColor: Colors.white,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailPage(cocktail: cocktail),
                      )),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                topLeft: Radius.circular(8),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: '${cocktail.thumb}/preview',
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                                placeholder: (context, url) =>
                                    const SkeletonAvatar(
                                  style: SkeletonAvatarStyle(
                                      width: 100, height: 100),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Icon(
                                    Icons.no_drinks,
                                    color: Colors.black38,
                                    size: 60,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cocktail.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  cocktail.measures.isNotEmpty
                                      ? cocktail.measures.first.ingredient.name
                                      : 'Unknown',
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  cocktail.category,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        : const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Whoops, we have nothing to show here!'),
            ),
          );
  }
}
