import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app2/data/models/restaurant_detail.dart';
import 'package:restaurant_app2/data/models/restaurant_list.dart';

class ApiService {
  static final String _baseUrl = "https://restaurant-api.dicoding.dev/";
  static final String _apiKey = "12345";

  Future<RestaurantList> restaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));

    if (response.statusCode == 200) {
      return RestaurantList.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get the list of restaurants.');
    }
  }

  Future<RestaurantDetail> restaurantDetailById(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "/detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get the detail of restaurant.');
    }
  }
}
