import 'package:hive/hive.dart';
import 'package:restaurant/domain/entity/restaurantsetting/set_receive_notification_setting_response.dart';

import '../../../misc/constant.dart';
import 'restaurant_setting_data_source.dart';

class DefaultRestaurantSettingDataSource implements RestaurantSettingDataSource {
  @override
  Future<bool> getReceiveNotificationSetting() async {
    Box box = await Hive.openBox(Constant.textRestaurantSettingHiveTableKey);
    bool receiveNotification = await box.get(Constant.textReceiveNotificationRestaurantSettingKey, defaultValue: false);
    box.close();
    return receiveNotification;
  }

  @override
  Future<SetReceiveNotificationSettingResponse> setReceiveNotificationSetting() async {
    Box box = await Hive.openBox(Constant.textRestaurantSettingHiveTableKey);
    bool result = !box.get(Constant.textReceiveNotificationRestaurantSettingKey, defaultValue: false);
    box.put(Constant.textReceiveNotificationRestaurantSettingKey, result);
    box.close();
    return SetReceiveNotificationSettingResponse(result: result);
  }
}