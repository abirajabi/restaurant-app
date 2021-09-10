import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/restaurant_list_provider.dart';
import 'package:restaurant_app2/ui/restaurant_overview_screen.dart';

class HomeScreen extends StatefulWidget {
  static final String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _listWidget = [
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
            create: (_) => RestaurantListProvider(apiService: ApiService())),
      ],
      child: RestaurantOverviewScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[0],
    );
  }
}
