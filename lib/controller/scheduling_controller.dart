import 'package:get/get.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/controller/preferences_controller.dart';
import 'package:restaurant_app2/utils/background_service.dart';

class SchedulingController extends GetxController {
  bool _isScheduled = false;

  @override
  void onInit() {
    var prefs = Get.put(PreferencesController());
    _isScheduled = prefs.isDailyReminderActive.value;
    if (_isScheduled)
      AndroidAlarmManager.oneShot(
          Duration(seconds: 1), NOTIFICATION_ID, BackgroundService.callback,
          exact: true, wakeup: true);
    super.onInit();
  }

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledReminder(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Restaurant Activated');
      update();
      return await AndroidAlarmManager.oneShot(
          Duration(seconds: 1), NOTIFICATION_ID, BackgroundService.callback,
          exact: true, wakeup: true);
    } else {
      print('Scheduling canceled');
      update();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
