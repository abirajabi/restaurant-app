import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/palette.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/preferences/preferences_helper.dart';
import 'package:restaurant_app2/provider/preferences_provider.dart';
import 'package:restaurant_app2/provider/restaurant_list_provider.dart';
import 'package:restaurant_app2/ui/home_screen.dart';
import 'package:restaurant_app2/ui/restaurant_detail_screen.dart';
import 'package:restaurant_app2/ui/restaurant_overview_screen.dart';
import 'package:restaurant_app2/ui/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        ),
      ],
      child: Sizer(
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
      ),
    );
  }
}
