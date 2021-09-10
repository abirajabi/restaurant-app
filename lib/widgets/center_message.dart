import 'package:flutter/material.dart';
import 'package:restaurant_app2/common/styles.dart';

class CenterMessage extends StatelessWidget {
  final String message;

  CenterMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: myTextTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
