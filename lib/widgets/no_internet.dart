import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: Column(
            children: [
              Image.asset(
                'no-internet.png',
                width: 250,
              ),
              Text(
                  "Sorry we couldn\'t access the data right now. Please check your internet connection."),
            ],
          ),
        ),
      ),
    );
  }
}
