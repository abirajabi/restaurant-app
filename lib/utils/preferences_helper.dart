import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
  static const DAILY_REMINDER = 'DAILY_REMINDER';

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isDailyNewsActivated async {
    SharedPreferences prefs = await sharedPreferences;
    return prefs.getBool(DAILY_REMINDER) ?? false;
  }
}
