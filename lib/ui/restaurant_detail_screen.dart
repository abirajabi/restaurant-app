import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/restaurant_detail_provider.dart';

class RestaurantDetailScreen extends StatelessWidget {
  static final String routeName = '/detail';

  @override
  Widget build(BuildContext context) {
    final String resId = ModalRoute.of(context)!.settings.arguments as String;
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: ApiService(), resId: resId),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: secondaryColor,
                ),
              );
            } else if (state.state == ResultState.HasData) {
              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 300,
                      pinned: true,
                      backgroundColor: purple2,
                    ),
                  ];
                },
                body: _buildDetail(),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Unknown Error'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildDetail() {
    return Container();
  }
}
