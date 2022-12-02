import '../../../domain/entity/restaurant/add_or_remove_restaurant_to_favorite_response.dart';
import '../../../domain/entity/restaurant/restaurant.dart';
import '../../../domain/entity/restaurant/restaurant_detail.dart';
import '../../../domain/entity/restaurant/restaurant_search_response.dart';

abstract class RestaurantDataSource {
  Future<List<Restaurant>> getRestaurantList();
  Future<RestaurantDetail> getRestaurantDetail(String restaurantId);
  Future<RestaurantSearchResponse> searchRestaurant(String query);
  Future<List<Restaurant>> getFavoriteRestaurant();
  Future<AddOrRemoveRestaurantToFavoriteResponse> addOrRemoveRestaurantToFavorite(String restaurantId);
  Future<bool> isMarkedAsFavoriteRestaurant(String restaurantId);
}