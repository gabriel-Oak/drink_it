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
    return ListView.builder(
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
                        child: Stack(children: [
                          const SkeletonAvatar(
                            style: SkeletonAvatarStyle(width: 100, height: 100),
                          ),
                          Image(
                            image: NetworkImage('${cocktail.thumb}/preview'),
                            alignment: Alignment.center,
                            fit: BoxFit.cover,
                            height: 100,
                            width: 100,
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
    );
  }
}
