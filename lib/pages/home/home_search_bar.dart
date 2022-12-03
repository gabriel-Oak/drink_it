import 'package:drink_it/pages/home/home_bloc.dart';
import 'package:drink_it/pages/home/home_event.dart';
import 'package:drink_it/pages/home/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeSearchBar extends StatelessWidget {
  final SearchMode searchMode;
  final String? selectedFilter;

  const HomeSearchBar({
    super.key,
    this.selectedFilter,
    required this.searchMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.only(right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: _buildSearchBar(context),
        ),
      ),
    );
  }

  List<Widget> _buildSearchBar(BuildContext context) {
    if (searchMode == SearchMode.ingredients) {
      return [
        _buildButton(
          context,
          onPressed: () => _searchIngredient(context, 'lemon'),
          title: 'Lemon',
          icon: FontAwesomeIcons.lemon,
          isActive: selectedFilter != null && selectedFilter!.contains('lemon'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchIngredient(context, 'whiskey'),
          title: 'Whiskey',
          icon: FontAwesomeIcons.whiskeyGlass,
          isActive:
              selectedFilter != null && selectedFilter!.contains('whiskey'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchIngredient(context, 'wine'),
          title: 'Wine',
          icon: FontAwesomeIcons.wineGlass,
          isActive: selectedFilter != null && selectedFilter!.contains('wine'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchIngredient(context, 'beer'),
          title: 'Beer',
          icon: FontAwesomeIcons.beerMugEmpty,
          isActive: selectedFilter != null && selectedFilter!.contains('beer'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchIngredient(context, 'gin'),
          title: 'Gin',
          icon: FontAwesomeIcons.martiniGlassEmpty,
          isActive: selectedFilter != null && selectedFilter!.contains('gin'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchIngredient(context, 'coffee'),
          title: 'Coffee',
          icon: FontAwesomeIcons.mugSaucer,
          isActive:
              selectedFilter != null && selectedFilter!.contains('coffee'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchIngredient(context, 'vodka'),
          title: 'Vodka',
          icon: FontAwesomeIcons.martiniGlassCitrus,
          isActive: selectedFilter != null && selectedFilter!.contains('vodka'),
        ),
      ];
    }

    if (searchMode == SearchMode.category) {
      return [
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'soft drink'),
          title: 'Soft Drink',
          icon: FontAwesomeIcons.wineGlassEmpty,
          isActive:
              selectedFilter != null && selectedFilter!.contains('soft drink'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'beer'),
          title: 'Beer',
          icon: FontAwesomeIcons.beerMugEmpty,
          isActive: selectedFilter != null && selectedFilter!.contains('beer'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'coffee / tea'),
          title: 'Coffee / Tea',
          icon: FontAwesomeIcons.mugSaucer,
          isActive: selectedFilter != null &&
              selectedFilter!.contains('coffee / tea'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'punch / party drink'),
          title: 'Party Drink',
          icon: FontAwesomeIcons.martiniGlassCitrus,
          isActive: selectedFilter != null &&
              selectedFilter!.contains('punch / party drink'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'homemade liqueur'),
          title: 'Liqueur',
          icon: FontAwesomeIcons.wineBottle,
          isActive: selectedFilter != null &&
              selectedFilter!.contains('homemade liqueur'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'shot'),
          title: 'Shot',
          icon: FontAwesomeIcons.whiskeyGlass,
          isActive: selectedFilter != null && selectedFilter!.contains('shot'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'cocoa'),
          title: 'Cocoa',
          icon: FontAwesomeIcons.mugHot,
          isActive: selectedFilter != null && selectedFilter!.contains('cocoa'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'shake'),
          title: 'Shake',
          icon: FontAwesomeIcons.blender,
          isActive: selectedFilter != null && selectedFilter!.contains('shake'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'ordinary drink'),
          title: 'Ordinary Drink',
          icon: FontAwesomeIcons.glassWater,
          isActive: selectedFilter != null &&
              selectedFilter!.contains('ordinary drink'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchCategory(context, 'cocktail'),
          title: 'Cocktail',
          icon: FontAwesomeIcons.martiniGlassCitrus,
          isActive:
              selectedFilter != null && selectedFilter!.contains('cocktail'),
        ),
      ];
    }

    if (searchMode == SearchMode.alcoholic) {
      return [
        _buildButton(
          context,
          onPressed: () => _searchAlcoholic(context, 'non alcoholic'),
          title: 'Non Alcoholic',
          icon: FontAwesomeIcons.martiniGlassEmpty,
          isActive: selectedFilter != null &&
              selectedFilter!.contains('non alcoholic'),
        ),
        _buildButton(
          context,
          onPressed: () => _searchAlcoholic(context, 'alcoholic'),
          title: 'Alcoholic',
          icon: FontAwesomeIcons.martiniGlassCitrus,
          isActive: selectedFilter != null && selectedFilter == 'alcoholic',
        ),
      ];
    }

    return [];
  }

  Widget _buildButton(
    BuildContext context, {
    required void Function() onPressed,
    required bool isActive,
    required String title,
    required IconData icon,
  }) =>
      Container(
        margin: const EdgeInsets.only(left: 16),
        child: Column(
          children: [
            Ink(
              padding: const EdgeInsets.all(10),
              decoration: ShapeDecoration(
                color: isActive ? Colors.red[400] : Colors.red[100],
                shape: const CircleBorder(),
              ),
              child: IconButton(
                icon: FaIcon(
                  icon,
                  color: isActive ? Colors.white : Colors.black54,
                ),
                color: Colors.white,
                onPressed: isActive ? () {} : onPressed,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: isActive ? () {} : onPressed,
              child: Text(
                title,
                style: TextStyle(
                  color: isActive ? Colors.red[400] : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );

  void _searchIngredient(BuildContext context, String ingredient) =>
      BlocProvider.of<HomeBloc>(context)
          .add(SearchByIngredientEvent(ingredient));

  void _searchCategory(BuildContext context, String category) =>
      BlocProvider.of<HomeBloc>(context).add(SearchByCategoryEvent(category));

  void _searchAlcoholic(BuildContext context, String alcoholic) =>
      BlocProvider.of<HomeBloc>(context).add(SearchByAlcoholicEvent(alcoholic));
}
