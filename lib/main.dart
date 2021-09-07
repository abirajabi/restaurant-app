import 'package:flutter/material.dart';
import 'package:restaurant_app2/common/palette.dart';
import 'package:restaurant_app2/ui/home_screen.dart';
import 'package:restaurant_app2/ui/restaurant_detail_screen.dart';
import 'package:restaurant_app2/ui/restaurant_overview_screen.dart';
import 'package:restaurant_app2/ui/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(primarySwatch: Palette.purple),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (context) => HomeScreen(),
        RestaurantOverviewScreen.routeName: (context) =>
            RestaurantOverviewScreen(),
        RestaurantDetailScreen.routeName: (context) => RestaurantDetailScreen(),
      },
    );
  }
}
