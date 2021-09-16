import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app2/data/db/hm_restaurant.dart';
import 'package:restaurant_app2/widgets/restaurant_card.dart';
import 'package:restaurant_app2/common/const.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your favorite restaurants'),
      ),
      body: _buildFavoriteList(),
    );
  }

  Widget _buildFavoriteList() {
    return ValueListenableBuilder(
      valueListenable: Hive.box<HiveRestaurant>(BOX_FAVORITE).listenable(),
      builder: (context, Box box, child) {
        return ListView.builder(
          itemCount: box.values.length,
          itemBuilder: (context, index) {
            final resto = box.getAt(index) as HiveRestaurant;

            return RestaurantCard(
              resto: resto.toResList(),
            );
          },
        );
      },
    );
  }
}
