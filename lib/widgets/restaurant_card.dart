import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_list.dart';
import 'package:restaurant_app2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app2/ui/restaurant_detail_screen.dart';

class RestaurantCard extends StatelessWidget {
  static final _baseUrl = "https://restaurant-api.dicoding.dev/images/";

  final Restaurant resto;

  RestaurantCard({required this.resto});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: _customCard(context),
    );
  }

  Widget _customCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailScreen.routeName,
            arguments: resto.id);
      },
      child: Card(
        shadowColor: purple1,
        elevation: 1,
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  _baseUrl + "small/" + resto.pictureId,
                  width: 100,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
