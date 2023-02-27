import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tidal_redesign/color_constant.dart';
import 'package:tidal_redesign/screens/PlaylistScreen.dart';
import 'package:tidal_redesign/screens/FavoritesScreen.dart';
import 'package:tidal_redesign/screens/Home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:tidal_redesign/screens/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  final screens = [Home(), FavoriteScreen(), PlaylistScreen(), SettingScreen()];

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Color(0xFFFEEFEC),
        bottomNavigationBar: Container(
          color: ColorConstants.kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              curve: Curves.easeOutExpo,
              gap: 8,
              backgroundColor: ColorConstants.kPrimaryColor,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade500,

              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'favorite',
                ),
                GButton(
                  icon: Icons.playlist_add_circle_rounded,
                  text: 'playlist',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
              ],
              selectedIndex: index,
              onTabChange: (index) {
                setState(() {
                  this.index = index;
                });
              },
              // key: navigationKey,
              // color: Color(0xFF320B4F),
              // backgroundColor: Colors.transparent,
              // height: 60,
              // index: index,
              // items: items,
              // onTap: (index) => setState(() => this.index = index),
            ),
          ),
        ),
        body: screens[index]);
  }
}
