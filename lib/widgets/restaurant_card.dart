import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/data/models/restaurant_list.dart';
import 'package:restaurant_app2/ui/restaurant_detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  static final _baseUrl = "https://restaurant-api.dicoding.dev/images/";

  final Restaurant resto;

  RestaurantCard({required this.resto});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blue,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: _customCard(context),
    );
  }

  Widget _customCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(RestaurantDetailScreen.routeName, arguments: resto.id);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Hero(
                      tag: resto.pictureId,
                      child: Image.network(
                        _baseUrl + "small/" + resto.pictureId,
                        width: 100,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            resto.name,
                            style: myTextTheme.headline6,
                            overflow: TextOverflow.visible,
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 16.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                resto.city,
                                style: myTextTheme.caption,
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                resto.rating.toString(),
                                style: myTextTheme.caption,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
