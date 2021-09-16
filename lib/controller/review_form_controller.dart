import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/data/api/api_service.dart';

class ReviewFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReviewFormController());
  }
}

class ReviewFormController extends GetxController {
  late final ApiService apiService;
  final reviewFormKey = GlobalKey<FormState>();
  final _txtReview = TextEditingController();
  final _txtName = TextEditingController();

  @override
  void onInit() {
    apiService = ApiService();
    super.onInit();
  }

  String? validator(String value) {
    if (value.isEmpty) {
      return 'Review must be filled';
    }
    return null;
  }

  void postReview(String resId) async {
    if (reviewFormKey.currentState!.validate()) {
      bool postSuccess = await apiService.postCustomerReview(
          resId, _txtName.text, _txtReview.text);
      if (postSuccess) {
        Get.snackbar('Customer Review', 'Review added');
      } else {
        Get.snackbar('Customer Review', 'Failed to add review');
      }
    }
  }
}
