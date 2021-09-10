import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/search_provider.dart';
import 'package:restaurant_app2/widgets/center_message.dart';
import 'package:restaurant_app2/widgets/no_internet.dart';
import 'package:restaurant_app2/widgets/restaurant_search_card.dart';
import 'package:restaurant_app2/widgets/search_not_found.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/searchResult';
  final String searchQuery;
  final ApiService apiService;

  SearchScreen({required this.searchQuery, required this.apiService}) {}

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.NoData) {
          return SearchNotFound();
        } else if (state.state == ResultState.NoInternet) {
          return NoInternet();
        } else if (state.state == ResultState.Error) {
          return CenterMessage(message: state.message);
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.searchResult.founded,
            itemBuilder: (context, index) {
              return RestaurantSearchCard(
                  resto: state.searchResult.restaurants[index]);
            },
          );
        } else {
          return CenterMessage(message: 'Unknown Error');
        }
      },
    );
  }
}
