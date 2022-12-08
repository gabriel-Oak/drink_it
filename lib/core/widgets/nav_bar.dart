import 'package:drink_it/pages/favorites/favorites_page.dart';
import 'package:drink_it/pages/home/home_page.dart';
import 'package:drink_it/pages/profile/profile_page.dart';
import 'package:drink_it/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  const NavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(18), topLeft: Radius.circular(18)),
        boxShadow: [
          BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
        child: BottomNavigationBar(
          onTap: (value) => _navigate(context, value),
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FaIcon(
                  FontAwesomeIcons.house,
                  color: currentIndex == 0
                      ? Theme.of(context).primaryColor
                      : Colors.black38,
                ),
              ),
              label: '',
              tooltip: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: currentIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.black38,
                ),
              ),
              label: '',
              tooltip: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FaIcon(
                  FontAwesomeIcons.heart,
                  color: currentIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.black38,
                ),
              ),
              label: '',
              tooltip: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: FaIcon(
                  FontAwesomeIcons.circleUser,
                  color: currentIndex == 3
                      ? Theme.of(context).primaryColor
                      : Colors.black38,
                ),
              ),
              label: '',
              tooltip: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        if (currentIndex != 0) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HomePage(),
          ));
        }
        break;
      case 1:
        if (currentIndex != 1) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const SearchPage(),
          ));
        }
        break;
      case 2:
        if (currentIndex != 2) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FavoritesPage(),
          ));
        }
        break;
      case 3:
        if (currentIndex != 3) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ProfilePage(),
          ));
        }
        break;
      default:
    }
  }
}
