import 'package:drink_it/core/features/cocktail/models/cocktail_item_model.dart';
import 'package:drink_it/core/features/cocktail/models/cocktail_model.dart';
import 'package:drink_it/pages/detail/detail_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      padding: const EdgeInsets.only(top: 4, right: 16, left: 4),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final cocktail = list[index];
        final cocktailInfo = info[cocktail.id];

        return GestureDetector(
          onTap: () {
            if (cocktailInfo != null) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailPage(cocktail: cocktailInfo),
              ));
            }
          },
          child: Card(
            elevation: 1,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                SizedBox(
                  height: 91,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                    child: Stack(children: [
                      const SkeletonAvatar(
                        style: SkeletonAvatarStyle(width: 92, height: 92),
                      ),
                      Image(
                        image: NetworkImage('${cocktail.thumb}/preview'),
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        height: 92,
                        width: 92,
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        cocktailInfo?.ingredients.first.name ?? 'Unknown',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 2),
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
