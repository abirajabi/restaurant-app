import 'package:flutter/material.dart';
import 'package:restaurant_app2/widgets/center_message.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildFavoriteList(),
    );
  }

  Widget _buildFavoriteList() {
    return CenterMessage(message: 'You have no favorites');
  }
}
