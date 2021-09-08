import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'no-internet.png',
                width: 250,
              ),
              Text(
                "Sorry we couldn\'t access the data right now. Please check your internet connection.",
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
