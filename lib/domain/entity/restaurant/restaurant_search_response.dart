import 'restaurant.dart';

class RestaurantSearchResponse {
  int count;
  List<Restaurant> restaurantSearchResultList;

  RestaurantSearchResponse({
    required this.count,
    required this.restaurantSearchResultList
  });
}