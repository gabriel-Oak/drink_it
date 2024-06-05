import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int newPageIndex) callback;
  const NavBar({super.key, required this.currentIndex, required this.callback});

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
          onTap: callback,
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
}
