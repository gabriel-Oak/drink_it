import 'package:drink_it/core/widgets/build_appbar.dart';
import 'package:drink_it/core/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Center(
        child: Text('Favorites'),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 2),
    );
  }
}
