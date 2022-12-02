import 'dart:isolate';
import 'dart:math';
import 'dart:ui';

import '../domain/entity/restaurant/restaurant.dart';
import '../main.dart';
import 'injector.dart';
import 'load_data_result.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    LoadDataResult<List<Restaurant>> restaurantListLoadDataResult = await Injector.restaurantRepository.getRestaurantList();
    if (restaurantListLoadDataResult is SuccessLoadDataResult<List<Restaurant>>) {
      List<Restaurant> restaurantList = restaurantListLoadDataResult.value;
      await notificationHelper.showNotification(flutterLocalNotificationsPlugin, restaurantList[Random().nextInt(restaurantList.length)]);
    }
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}