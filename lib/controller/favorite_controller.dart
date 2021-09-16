import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/db/hm_restaurant.dart';

class FavoriteController extends GetxController {
  late Box<HiveRestaurant> box;

  @override
  void onInit() {
    box = Hive.box<HiveRestaurant>(BOX_FAVORITE);
    super.onInit();
  }

  void addFavorite(HiveRestaurant restaurant) async {
    try {
      box.put(restaurant.id, restaurant);
      update();
    } catch (e) {
      print('Failed adding favorite restaurant. $e');
    }
  }

  void removeRestaurant(String resId) {
    try {
      box.delete(resId);
      update();
    } catch (e) {
      print('Failed deleting favorite restaurant. $e');
    }
  }

  bool isFavorite(String resId) {
    var resto = box.values.where((item) => item.id == resId);
    if (resto.isNotEmpty) {
      return true;
    }
    return false;
  }
}
