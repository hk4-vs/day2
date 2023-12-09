import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'explore_view.dart';
import 'favorites_view.dart';
import 'home_view.dart';
import 'playlist_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const PlaylistView(),
    const FavoritesView(),
    const ExploreView(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white10,
        currentIndex: _currentIndex,
        useLegacyColorScheme: false,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.music_note_list),
            label: 'Playlist',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.heart,
            ),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.compass,
            ),
            label: 'Explore',
          ),
        ],
      ),
      body: PageView(
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
