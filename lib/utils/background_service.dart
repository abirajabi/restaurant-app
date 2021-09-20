import 'dart:isolate';
import 'dart:math';

import 'dart:ui';

import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/main.dart';
import 'package:restaurant_app2/utils/notification_service.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService.createObject();

  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService.createObject();
    }
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm fired');
    final NotificationService _notificationService = NotificationService();
    var result = await ApiService().restaurantList();

    Random random = new Random();
    int index = random.nextInt(result.count);

    var resto = result.restaurants[index];

    await _notificationService.showNotification(
        flutterLocalNotificationsPlugin, resto);

    _uiSendPort ?? IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
