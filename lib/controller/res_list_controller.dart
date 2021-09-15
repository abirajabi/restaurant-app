import 'dart:io';

import 'package:get/get.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_list.dart';

class ResListController extends GetxController {
  final ApiService apiService;

  String _message = '';
  late ResultState _state;
  late RestaurantList _restaurants;

  String get message => _message;

  ResListController({required this.apiService});

  @override
  void onInit() {
    _fetchAllRestaurant();
    super.onInit();
  }

  ResultState get state => _state;

  RestaurantList get restaurants => _restaurants;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      update();
      final response = await apiService.restaurantList();
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        update();
      } else {
        _state = ResultState.HasData;
        update();
        return _restaurants = response;
      }
    } on SocketException catch (e) {
      _state = ResultState.NoInternet;
      update();
      return _message = "Error no internet: $e";
    } on HandshakeException catch (e) {
      _state = ResultState.NoInternet;
      update();
      return _message = "Error no internet: $e";
    } catch (e) {
      _state = ResultState.Error;
      update();
      return _message = 'Error --> $e';
    }
  }
}
