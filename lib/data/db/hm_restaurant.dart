import 'package:hive/hive.dart';
import 'package:restaurant_app2/data/models/restaurant_list.dart' as resList;
import 'package:restaurant_app2/data/models/restaurant_detail.dart'
    as resDetail;

part 'hm_restaurant.g.dart';

@HiveType(typeId: 0)
class HiveRestaurant {
  HiveRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String pictureId;
  @HiveField(4)
  String city;
  @HiveField(5)
  double rating;

  factory HiveRestaurant.fromResList(resList.Restaurant restaurant) {
    return HiveRestaurant(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating);
  }

  factory HiveRestaurant.fromResDetail(resDetail.Restaurant restaurant) {
    return HiveRestaurant(
        id: restaurant.id,
        name: restaurant.name,
        description: restaurant.description,
        pictureId: restaurant.pictureId,
        city: restaurant.city,
        rating: restaurant.rating);
  }

  resList.Restaurant toResList() {
    return resList.Restaurant(
        id: id,
        name: name,
        description: description,
        pictureId: pictureId,
        city: city,
        rating: rating);
  }
}
