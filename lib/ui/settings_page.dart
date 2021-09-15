import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/controller/preferences_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetX<PreferencesController>(
          init: PreferencesController(),
          builder: (controller) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Daily Reminder', style: myTextTheme.headline6),
              Switch(
                value: controller.isDailyReminderActive.value,
                onChanged: (value) {
                  controller.setDailyReminder(value);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
