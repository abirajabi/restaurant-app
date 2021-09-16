import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:restaurant_app2/controller/favorite_controller.dart';
import 'package:restaurant_app2/data/db/hm_restaurant.dart';
import 'package:restaurant_app2/widgets/restaurant_card.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatelessWidget {
  final favController = Get.put(FavoriteController());

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
            return Dismissible(
              key: Key(resto.id),
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.redAccent,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 10.w,
                  ),
                ),
              ),
              child: RestaurantCard(
                resto: resto.toResList(),
              ),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                favController.removeRestaurant(resto.id);
                favController.removedFromFavorite(resto.name);
              },
            );
          },
        );
      },
    );
  }
}
