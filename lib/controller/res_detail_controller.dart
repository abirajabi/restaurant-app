import 'dart:io';

import 'package:get/get.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_detail.dart';

class ResDetailController extends GetxController {
  final ApiService apiService;
  final String resId;

  ResDetailController({required this.apiService, required this.resId});

  ResultState _state = ResultState.Idle;
  late String _message = '';
  late RestaurantDetail _detail;

  ResultState get state => _state;

  String get message => _message;

  RestaurantDetail get detail => _detail;

  @override
  void onInit() {
    fetchRestaurantDetail();
    super.onInit();
  }

  Future<dynamic> fetchRestaurantDetail() async {
    try {
      _state = ResultState.Loading;
      update();
      final response = await apiService.restaurantDetailById(resId);
      if (response.restaurant == null) {
        _state = ResultState.NoData;
        update();
      } else {
        _state = ResultState.HasData;
        update();
        return _detail = response;
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
