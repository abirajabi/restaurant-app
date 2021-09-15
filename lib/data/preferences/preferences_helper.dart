import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const DAILY_REMINDER = 'DAILY_REMINDER';

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isDailyReminderActivated async {
    SharedPreferences prefs = await sharedPreferences;
    return prefs.getBool(DAILY_REMINDER) ?? false;
  }

  Future<bool> setDailyReminder(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_REMINDER, value);
    return value;
  }
}
