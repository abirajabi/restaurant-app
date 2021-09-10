import 'package:flutter/material.dart';
import 'package:restaurant_app2/common/styles.dart';

class SearchNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              color: purple1,
              size: 150,
            ),
            Text(
              'Sorry, data not found',
              style: myTextTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
