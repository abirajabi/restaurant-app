import 'package:get/get.dart';
import 'package:restaurant_app2/data/preferences/preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesController extends GetxController {
  PreferencesHelper prefsHelper =
      PreferencesHelper(sharedPreferences: SharedPreferences.getInstance());

  @override
  void onInit() {
    getDailyReminderPreferences();
    super.onInit();
  }

  final _isDailyReminderActive = false.obs;

  get isDailyReminderActive {
    return _isDailyReminderActive;
  }

  void getDailyReminderPreferences() async {
    isDailyReminderActive.value = await prefsHelper.isDailyReminderActivated;
  }

  void setDailyReminder(bool value) async {
    isDailyReminderActive.value = await prefsHelper.setDailyReminder(value);
  }
}
