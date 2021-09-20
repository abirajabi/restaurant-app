import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/data/api/api_service.dart';

class ReviewFormController extends GetxController {
  late final ApiService apiService;
  final _reviewFormKey = GlobalKey<FormState>();
  final _txtReview = TextEditingController();
  final _txtName = TextEditingController();

  get reviewFormKey => _reviewFormKey;

  get txtReview => _txtReview;

  get txtName => _txtName;

  @override
  void onInit() {
    apiService = ApiService();
    super.onInit();
  }

  @override
  void onClose() {
    _txtReview.dispose();
    _txtName.dispose();
    super.onClose();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Review must be filled';
    }
    return null;
  }

  void postReview(String resId) async {
    if (_reviewFormKey.currentState!.validate()) {
      bool postSuccess = await apiService.postCustomerReview(
          resId, _txtName.text, _txtReview.text);
      if (postSuccess) {
        _txtName.clear();
        _txtReview.clear();
        Get.snackbar('Customer Review', 'Review added');
        update();
      } else {
        _txtName.clear();
        _txtReview.clear();
        Get.snackbar('Customer Review', 'Failed to add review');
        update();
      }
    }
  }
}
