import 'dart:core';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app2/ui/favorite_screen.dart';
import 'package:restaurant_app2/ui/restaurant_overview_screen.dart';
import 'package:restaurant_app2/ui/settings_page.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavbarKey = GlobalKey();

  List<Widget> _listWidget = [
    RestaurantOverviewScreen(),
    FavoriteScreen(),
    SettingsPage(),
  ];

  List<Widget> bottomNavbarItems = [
    Icon(
      Icons.fastfood,
      color: Colors.white,
    ),
    Icon(
      Icons.favorite,
      color: Colors.white,
    ),
    Icon(
      Icons.settings,
      color: Colors.white,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _listWidget.elementAt(_page),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavbarKey,
        items: bottomNavbarItems,
        index: _page,
        color: Color(0xFF6457A6),
        height: 7.h,
        buttonBackgroundColor: Color(0xFF6457A6),
        backgroundColor: Colors.transparent,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
