import 'dart:io';

import 'package:get/get.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_search.dart';

class SearchController extends GetxController {
  final ApiService apiService;
  final String query;

  @override
  void onInit() {
    fetchSearchResult(query);
    super.onInit();
  }

  SearchController({required this.apiService, required this.query});

  String _message = '';
  late ResultState _state;
  late RestaurantSearchList _searchResult;

  ResultState get state => _state;

  String get message => _message;

  RestaurantSearchList get searchResult => _searchResult;

  Future<dynamic> fetchSearchResult(String query) async {
    try {
      _state = ResultState.Loading;
      update();
      final response = await apiService.searchRestaurant(query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        update();
      } else {
        _state = ResultState.HasData;
        update();
        return _searchResult = response;
      }
    } on SocketException catch (e) {
      _state = ResultState.NoInternet;
      update();
      return _message = 'Error no internet: $e';
    } on HandshakeException catch (e) {
      _state = ResultState.NoInternet;
      update();
      return _message = 'Error no internet: $e';
    } catch (e) {
      _state = ResultState.Error;
      update();
      return _message = 'Error --> $e';
    }
  }
}
