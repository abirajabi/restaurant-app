import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_search.dart';

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  SearchProvider({required this.apiService, required this.query}) {
    fetchSearchResult(query);
  }

  String _message = '';
  late ResultState _state;
  late RestaurantSearchList _searchResult;

  ResultState get state => _state;

  String get message => _message;

  RestaurantSearchList get searchResult => _searchResult;

  Future<dynamic> fetchSearchResult(String query) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final response = await apiService.searchRestaurant(query);
      if (response.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _searchResult = response;
      }
    } on SocketException catch (e) {
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message = 'Error no internet: $e';
    } on HandshakeException catch (e) {
      _state = ResultState.NoInternet;
      notifyListeners();
      return _message = 'Error no internet: $e';
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
