import 'package:hive/hive.dart';

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
}
