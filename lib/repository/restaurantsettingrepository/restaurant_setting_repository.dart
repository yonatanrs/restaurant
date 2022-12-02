import '../../domain/entity/restaurantsetting/set_receive_notification_setting_response.dart';
import '../../misc/load_data_result.dart';

abstract class RestaurantSettingRepository {
  Future<LoadDataResult<bool>> getReceiveNotificationSetting();
  Future<LoadDataResult<SetReceiveNotificationSettingResponse>> setReceiveNotificationSetting();
}