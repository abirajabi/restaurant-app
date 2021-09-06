import 'package:flutter/foundation.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_list.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  String _message = '';
  late ResultState _state;
  late RestaurantList _restaurants;

  String get message => _message;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  ResultState get state => _state;

  RestaurantList get restaurants => _restaurants;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.restaurantList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurants = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
