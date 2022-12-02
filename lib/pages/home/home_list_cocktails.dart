import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeListCocktails extends StatelessWidget {
  final List<CocktailItem> list;
  final Map<String, Cocktail?> info;

  const HomeListCocktails({
    super.key,
    required this.list,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, right: 16, left: 2),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final cocktail = list[index];
        final cocktailInfo = info[cocktail.id];

        return Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: SizedBox(
                    height: 80,
                    width: 80,
                    child: Stack(children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 80, height: 80),
                      ),
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Image(
                          image: NetworkImage(cocktail.thumb),
                        ),
                      ),
                    ]),
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
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cocktailInfo?.ingredients.first.name ?? 'Unknown',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        cocktailInfo?.category ?? 'Unknow',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
