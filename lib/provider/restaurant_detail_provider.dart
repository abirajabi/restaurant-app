import 'package:flutter/foundation.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_detail.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String resId;

  RestaurantDetailProvider({required this.apiService, required this.resId}) {
    _fetchRestaurantDetail();
  }

  ResultState? _state;

  ResultState? get state => _state;
  late String _message;
  late RestaurantDetail _details;

  String get message => _message;

  RestaurantDetail get details => _details;

  Future<dynamic> _fetchRestaurantDetail() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.restaurantDetailById(resId);
      if (response.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _details = response;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = "Error --> $e";
    }
  }
}
