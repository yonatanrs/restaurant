import 'package:dio/dio.dart';

import '../data/datasource/restaurantdatasource/default_restaurant_data_source.dart';
import '../data/datasource/restaurantdatasource/restaurant_data_source.dart';
import '../data/datasource/restaurantsettingdatasource/default_restaurant_setting_data_source.dart';
import '../data/datasource/restaurantsettingdatasource/restaurant_setting_data_source.dart';
import '../repository/restaurantrepository/default_restaurant_repository.dart';
import '../repository/restaurantrepository/restaurant_repository.dart';
import '../repository/restaurantsettingrepository/default_restaurant_setting_repository.dart';
import '../repository/restaurantsettingrepository/restaurant_setting_repository.dart';
import 'errorprovider/default_error_provider.dart';
import 'errorprovider/error_provider.dart';
import 'http_client.dart';

class _Injector {
  Dio? _dio;
  Dio get _dioHttpClient {
    _dio ??= DioHttpClient.of();
    return _dio!;
  }

  RestaurantDataSource? _restaurantDataSource;
  RestaurantDataSource get restaurantDataSource {
    _restaurantDataSource ??= DefaultRestaurantDataSource(dio: _dioHttpClient);
    return _restaurantDataSource!;
  }

  RestaurantRepository? _restaurantRepository;
  RestaurantRepository get restaurantRepository {
    _restaurantRepository ??= DefaultRestaurantRepository(restaurantDataSource: restaurantDataSource);
    return _restaurantRepository!;
  }

  RestaurantSettingDataSource? _restaurantSettingDataSource;
  RestaurantSettingDataSource get restaurantSettingDataSource {
    _restaurantSettingDataSource ??= DefaultRestaurantSettingDataSource();
    return _restaurantSettingDataSource!;
  }

  RestaurantSettingRepository? _restaurantSettingRepository;
  RestaurantSettingRepository get restaurantSettingRepository {
    _restaurantSettingRepository ??= DefaultRestaurantSettingRepository(restaurantSettingDataSource: restaurantSettingDataSource);
    return _restaurantSettingRepository!;
  }

  final ErrorProvider _errorProvider = DefaultErrorProvider();
  ErrorProvider get errorProvider => _errorProvider;
}

// ignore: non_constant_identifier_names
final Injector = _Injector();