import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app2/data/models/restaurant_detail.dart'
    as resDetail;
import 'package:restaurant_app2/data/models/restaurant_list.dart' as resList;
import 'package:restaurant_app2/data/models/restaurant_search.dart'
    as resSearch;

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String _apiKey = "12345";

  Future<resList.RestaurantList> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));

    if (response.statusCode == 200) {
      return resList.RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get the list of restaurants.');
    }
  }

  Future<resDetail.RestaurantDetail> restaurantDetailById(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/$id"));

    if (response.statusCode == 200) {
      return resDetail.RestaurantDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get the detail of restaurant.');
    }
  }

  Future<bool> postCustomerReview(
      String resId, String name, String review) async {
    bool success = false;
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'X-Auth-Token': _apiKey,
    };
    final body = jsonEncode({
      'id': resId,
      'name': name,
      'review': review,
    });

    final response = await http.post(
      Uri.parse(_baseUrl + "review/"),
      body: body,
      headers: headers,
    );

    if (response.statusCode == 200) {
      success = true;
    } else {
      success = false;
      throw Exception('Failed to post your review');
    }
    return success;
  }

  Future<List<resSearch.Restaurant>> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));

    if (response.statusCode == 200) {
      print(response.body);
      List<resSearch.Restaurant> restaurantList =
          resSearch.RestaurantSearchList.fromJson(jsonDecode(response.body))
              .restaurants;

      if (restaurantList.isNotEmpty) {
        return restaurantList;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to find restaurant');
    }
  }
}
