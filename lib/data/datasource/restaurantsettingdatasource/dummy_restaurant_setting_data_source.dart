import 'package:restaurant/domain/entity/restaurantsetting/set_receive_notification_setting_response.dart';

import 'restaurant_setting_data_source.dart';

class DummyRestaurantSettingDataSource implements RestaurantSettingDataSource {
  @override
  Future<bool> getReceiveNotificationSetting() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  Future<SetReceiveNotificationSettingResponse> setReceiveNotificationSetting() async {
    await Future.delayed(const Duration(seconds: 1));
    return SetReceiveNotificationSettingResponse(result: true);
  }
}