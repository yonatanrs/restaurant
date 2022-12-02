import '../../domain/entity/restaurant/add_or_remove_restaurant_to_favorite_response.dart';
import '../../domain/entity/restaurant/restaurant.dart';
import '../../domain/entity/restaurant/restaurant_detail.dart';
import '../../domain/entity/restaurant/restaurant_search_response.dart';
import '../../misc/load_data_result.dart';

abstract class RestaurantRepository {
  Future<LoadDataResult<List<Restaurant>>> getRestaurantList();
  Future<LoadDataResult<RestaurantDetail>> getRestaurantDetail(String restaurantId);
  Future<LoadDataResult<RestaurantSearchResponse>> searchRestaurant(String query);
  Future<LoadDataResult<List<Restaurant>>> getFavoriteRestaurant();
  Future<LoadDataResult<AddOrRemoveRestaurantToFavoriteResponse>> addOrRemoveRestaurantToFavorite(String restaurantId);
  Future<LoadDataResult<bool>> isMarkedAsFavoriteRestaurant(String restaurantId);
}