import 'package:drink_it/pages/home/home_state.dart';
import 'package:flutter/material.dart';
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
          onPressed: () {},
          title: 'Vodka',
          icon: FontAwesomeIcons.glassWater,
          isActive: selectedFilter != null && selectedFilter!.contains('vodka'),
        ),
        _buildButton(
          context,
          onPressed: () {},
          title: 'Martini',
          icon: FontAwesomeIcons.martiniGlassCitrus,
          isActive:
              selectedFilter != null && selectedFilter!.contains('martini'),
        ),
        _buildButton(
          context,
          onPressed: () {},
          title: 'Wine',
          icon: FontAwesomeIcons.wineGlass,
          isActive: selectedFilter != null && selectedFilter!.contains('wine'),
        ),
      ];
    }

    if (searchMode == SearchMode.category) {
      return [];
    }

    if (searchMode == SearchMode.alcoholic) {
      return [];
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
}
