import 'package:drink_it/core/widgets/build_appbar.dart';
import 'package:drink_it/core/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: const Center(
        child: Text('Profile'),
      ),
      bottomNavigationBar: const NavBar(currentIndex: 3),
    );
  }
}
