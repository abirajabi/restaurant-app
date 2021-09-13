import 'dart:core';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/preferences_provider.dart';
import 'package:restaurant_app2/provider/restaurant_list_provider.dart';
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
    ChangeNotifierProvider(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: RestaurantOverviewScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => PreferencesProvider(),
      child: SettingsPage(),
    ),
    // SettingsPage();
  ];

  List<Widget> bottomNavbarItems = [
    Icon(
      Icons.fastfood,
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
      body: _listWidget[0],
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
