import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant/misc/ext/restaurant_ext.dart';
import 'package:rxdart/rxdart.dart';

import '../domain/entity/restaurant/restaurant.dart';
import '../presentation/page/restaurant_detail_page.dart';
import 'navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = const AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) async {
        final payload = details.payload;
        selectNotificationSubject.add(payload ?? 'empty payload');
      }
    );
  }

  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, Restaurant restaurant) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDescription = "restaurant recommendation";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId, channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true)
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
    );

    var titleNotification = "<b>Retaurant Recommendation</b>";
    var titleNews = restaurant.name;

    await flutterLocalNotificationsPlugin.show(0, titleNotification, titleNews, platformChannelSpecifics, payload: json.encode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen((String payload) async {
      dynamic parsingData = json.decode(payload);
      Restaurant restaurant = (parsingData is Map<String, dynamic> ? parsingData : <String, dynamic>{}).fromJson();
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (BuildContext context) => RestaurantDetailPage(restaurantId: restaurant.id))
      );
    });
  }
}