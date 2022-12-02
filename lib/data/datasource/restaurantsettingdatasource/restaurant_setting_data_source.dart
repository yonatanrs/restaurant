import '../../../domain/entity/restaurantsetting/set_receive_notification_setting_response.dart';

abstract class RestaurantSettingDataSource {
  Future<bool> getReceiveNotificationSetting();
  Future<SetReceiveNotificationSettingResponse> setReceiveNotificationSetting();
}