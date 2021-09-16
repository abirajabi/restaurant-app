import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app2/common/palette.dart';
import 'package:restaurant_app2/data/db/hm_restaurant.dart';
import 'package:restaurant_app2/ui/home_screen.dart';
import 'package:restaurant_app2/ui/restaurant_detail_screen.dart';
import 'package:restaurant_app2/ui/restaurant_overview_screen.dart';
import 'package:restaurant_app2/ui/splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:hive/hive.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HiveRestaurantAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Restaurant App',
          theme: ThemeData(primarySwatch: Palette.purple),
          home: SplashScreen(),
          debugShowCheckedModeBanner: false,
          routes: {
            HomeScreen.routeName: (context) => HomeScreen(),
            RestaurantOverviewScreen.routeName: (context) =>
                RestaurantOverviewScreen(),
            RestaurantDetailScreen.routeName: (context) =>
                RestaurantDetailScreen(),
          },
        );
      },
    );
  }
}
