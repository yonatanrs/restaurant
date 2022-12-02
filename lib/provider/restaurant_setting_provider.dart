import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

import '../domain/entity/restaurantsetting/set_receive_notification_setting_response.dart';
import '../misc/background_service.dart';
import '../misc/date_time_helper.dart';
import '../misc/load_data_result.dart';
import '../repository/restaurantsettingrepository/restaurant_setting_repository.dart';

class RestaurantSettingProvider extends ChangeNotifier {
  final RestaurantSettingRepository restaurantSettingRepository;

  LoadDataResult<bool> _receiveNotificationSettingResponseLoadDataResult = NoLoadDataResult<bool>();
  LoadDataResult<bool> get receiveNotificationSettingResponseLoadDataResult => _receiveNotificationSettingResponseLoadDataResult;

  RestaurantSettingProvider({required this.restaurantSettingRepository}) {
    getReceiveNotificationSettingResponse();
  }

  void getReceiveNotificationSettingResponse() async {
    _receiveNotificationSettingResponseLoadDataResult = IsLoadingLoadDataResult<bool>();
    notifyListeners();
    _receiveNotificationSettingResponseLoadDataResult = await restaurantSettingRepository.getReceiveNotificationSetting();
    notifyListeners();
  }

  void scheduledOrNotRestaurantRecommendation() async {
    _receiveNotificationSettingResponseLoadDataResult = IsLoadingLoadDataResult<bool>();
    notifyListeners();
    LoadDataResult<SetReceiveNotificationSettingResponse> setReceiveNotificationSettingResponseLoadDataResult = await restaurantSettingRepository.setReceiveNotificationSetting();
    notifyListeners();
    if (setReceiveNotificationSettingResponseLoadDataResult is SuccessLoadDataResult<SetReceiveNotificationSettingResponse>) {
      bool result = setReceiveNotificationSettingResponseLoadDataResult.value.result;
      _receiveNotificationSettingResponseLoadDataResult = SuccessLoadDataResult<bool>(value: result);
      notifyListeners();
      if (result) {
        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
        );
      } else {
        await AndroidAlarmManager.cancel(1);
      }
    }
  }
}