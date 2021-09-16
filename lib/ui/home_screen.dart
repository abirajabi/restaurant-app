import 'dart:core';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/db/hm_restaurant.dart';
import 'package:restaurant_app2/ui/favorite_screen.dart';
import 'package:restaurant_app2/ui/restaurant_overview_screen.dart';
import 'package:restaurant_app2/ui/settings_page.dart';
import 'package:restaurant_app2/widgets/center_message.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';

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
    FutureBuilder(
      future: Hive.openBox<HiveRestaurant>(BOX_FAVORITE),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return CenterMessage(message: snapshot.error.toString());
          } else {
            return FavoriteScreen();
          }
        } else {
          return CenterMessage(message: 'Failed to open database');
        }
      },
    ),
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

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
