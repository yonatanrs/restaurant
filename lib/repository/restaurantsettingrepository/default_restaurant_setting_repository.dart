import 'package:restaurant/misc/ext/future_ext.dart';

import '../../data/datasource/restaurantsettingdatasource/restaurant_setting_data_source.dart';
import '../../domain/entity/restaurantsetting/set_receive_notification_setting_response.dart';
import '../../misc/load_data_result.dart';
import 'restaurant_setting_repository.dart';

class DefaultRestaurantSettingRepository implements RestaurantSettingRepository {
  final RestaurantSettingDataSource restaurantSettingDataSource;

  DefaultRestaurantSettingRepository({
    required this.restaurantSettingDataSource
  });

  @override
  Future<LoadDataResult<bool>> getReceiveNotificationSetting() {
    return restaurantSettingDataSource.getReceiveNotificationSetting().getLoadDataResult();
  }

  @override
  Future<LoadDataResult<SetReceiveNotificationSettingResponse>> setReceiveNotificationSetting() {
    return restaurantSettingDataSource.setReceiveNotificationSetting().getLoadDataResult();
  }
}