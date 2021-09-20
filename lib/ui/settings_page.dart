import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/controller/preferences_controller.dart';
import 'package:restaurant_app2/controller/scheduling_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(SchedulingController());
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Settings', style: myTextTheme.bodyText1)),
      ),
      body: Center(
        child: GetX<PreferencesController>(
          init: PreferencesController(),
          builder: (controller) => ListView(
            children: [
              ListTile(
                title: Text(
                  'Daily reminder',
                  style: myTextTheme.bodyText2,
                ),
                trailing: Switch(
                  value: controller.isDailyReminderActive.value,
                  onChanged: (value) {
                    controller.setDailyReminder(value);
                    Get.find<SchedulingController>().scheduledReminder(value);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
