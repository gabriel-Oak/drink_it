import 'package:drink_it/core/widgets/build_appbar.dart';
import 'package:drink_it/core/widgets/nav_bar.dart';
import 'package:drink_it/pages/favorites/favorites_page.dart';
import 'package:drink_it/pages/home/home_page.dart';
import 'package:drink_it/pages/main/bloc/main_bloc.dart';
import 'package:drink_it/pages/main/bloc/main_event.dart';
import 'package:drink_it/pages/main/bloc/main_state.dart';
import 'package:drink_it/pages/profile/profile_page.dart';
import 'package:drink_it/pages/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) => Scaffold(
        appBar: buildAppBar(context, title: _getTitle(state.pageIndex)),
        backgroundColor: Colors.grey[100],
        bottomNavigationBar: NavBar(
          currentIndex: state.pageIndex,
          callback: (newPageIndex) => BlocProvider.of<MainBloc>(context)
              .add(ChangeMainPage(newPageIndex: newPageIndex)),
        ),
        body: _buildBody(context, state.pageIndex),
      ),
    );
  }

  Widget? _buildBody(BuildContext context, int pageIndex) {
    switch (pageIndex) {
      case 0:
        return const HomePage();

      case 1:
        return const SearchPage();

      case 2:
        return const FavoritesPage();

      case 3:
        return const ProfilePage();
      default:
        return null;
    }
  }

  String _getTitle(int pageIndex) {
    switch (pageIndex) {
      case 1:
        return 'Search';

      case 2:
        return 'Favorites';

      case 3:
        return 'Profile';

      default:
        return 'Drink.it';
    }
  }
}
