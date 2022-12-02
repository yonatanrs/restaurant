import 'package:restaurant/misc/ext/future_ext.dart';

import '../../data/datasource/restaurantdatasource/restaurant_data_source.dart';
import '../../domain/entity/restaurant/add_or_remove_restaurant_to_favorite_response.dart';
import '../../domain/entity/restaurant/restaurant.dart';
import '../../domain/entity/restaurant/restaurant_detail.dart';
import '../../domain/entity/restaurant/restaurant_search_response.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import 'restaurant_repository.dart';

class DefaultRestaurantRepository implements RestaurantRepository {
  final RestaurantDataSource restaurantDataSource;

  DefaultRestaurantRepository({
    required this.restaurantDataSource
  });

  @override
  Future<LoadDataResult<List<Restaurant>>> getRestaurantList() {
    return restaurantDataSource.getRestaurantList().getLoadDataResult();
  }

  @override
  Future<LoadDataResult<RestaurantDetail>> getRestaurantDetail(String restaurantId) {
    return restaurantDataSource.getRestaurantDetail(restaurantId).getLoadDataResult();
  }

  @override
  Future<LoadDataResult<RestaurantSearchResponse>> searchRestaurant(String query) {
    return restaurantDataSource.searchRestaurant(query).getLoadDataResult();
  }

  @override
  Future<LoadDataResult<List<Restaurant>>> getFavoriteRestaurant() async {
    return restaurantDataSource.getFavoriteRestaurant().getLoadDataResult();
  }

  @override
  Future<LoadDataResult<AddOrRemoveRestaurantToFavoriteResponse>> addOrRemoveRestaurantToFavorite(String restaurantId) async {
    return restaurantDataSource.addOrRemoveRestaurantToFavorite(restaurantId).getLoadDataResult();
  }

  @override
  Future<LoadDataResult<bool>> isMarkedAsFavoriteRestaurant(String restaurantId) {
    return restaurantDataSource.isMarkedAsFavoriteRestaurant(restaurantId).getLoadDataResult();
  }
}