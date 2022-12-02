import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/hiveentity/restaurant_hive_entity.dart';
import 'misc/background_service.dart';
import 'misc/navigation.dart';
import 'misc/notification_helper.dart';
import 'presentation/page/restaurant_page.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RestaurantHiveEntityAdapter());

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  notificationHelper.configureSelectNotificationSubject();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Restaurant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RestaurantPage(),
    );
  }
}