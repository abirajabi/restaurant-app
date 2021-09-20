import 'dart:convert';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/data/models/restaurant_list.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String?>();

class NotificationService extends GetxController {
  static final NotificationService _instance = NotificationService._internal();

  NotificationService._internal();

  factory NotificationService() => _instance;

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('notification_logo');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestAlertPermission: false,
      requestBadgePermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            iOS: initializationSettingsIOS,
            android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('Notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen((String? payload) {
      try {
        var restaurant = Restaurant.fromJson(jsonDecode(payload ?? ''));
        Get.toNamed(route, arguments: restaurant.id);
      } catch (e) {
        print('Error on decoding notification payload: $e');
      }
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      Restaurant restaurant) async {
    var _channelId = '01';
    var _channelName = 'channel_01';
    var _channelDesc = 'Restaurant Channel';

    var androidPlatformSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDesc,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        iOS: iOSPlatformSpecifics, android: androidPlatformSpecifics);

    var notificationTitle = '<b>New Restaurant for you!<b/>';
    var notificationBody =
        'Have you been to ${restaurant.name}? Find out right now!';

    await flutterLocalNotificationsPlugin.show(
        0, notificationTitle, notificationBody, platformChannelSpecifics,
        payload: jsonEncode(restaurant.toJson()));

    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //   NOTIFICATION_ID,
    //   notificationTitle,
    //   notificationBody,
    //   _nextInstanceOfElevenAM(),
    //   platformChannelSpecifics,
    //   androidAllowWhileIdle: true,
    //   uiLocalNotificationDateInterpretation:
    //       UILocalNotificationDateInterpretation.absoluteTime,
    //   matchDateTimeComponents: DateTimeComponents.time,
    // );
  }

  // tz.TZDateTime _nextInstanceOfElevenAM() {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledDate =
  //       tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
  //   if (scheduledDate.isBefore(now)) {
  //     scheduledDate = scheduledDate.add(const Duration(hours: 24));
  //   }
  //   return scheduledDate;
  // }
}
