import 'package:flutter/material.dart';

import '../domain/entity/restaurant/restaurant_search_response.dart';
import '../misc/load_data_result.dart';
import '../repository/restaurantrepository/restaurant_repository.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final RestaurantRepository restaurantRepository;

  LoadDataResult<RestaurantSearchResponse> _restaurantSearchResponseLoadDataResult = NoLoadDataResult<RestaurantSearchResponse>();
  LoadDataResult<RestaurantSearchResponse> get restaurantSearchResponseLoadDataResult => _restaurantSearchResponseLoadDataResult;

  RestaurantSearchProvider({required this.restaurantRepository}) {
    notifyListeners();
  }

  void searchRestaurantList(String query) async {
    _restaurantSearchResponseLoadDataResult = IsLoadingLoadDataResult<RestaurantSearchResponse>();
    notifyListeners();
    _restaurantSearchResponseLoadDataResult = await restaurantRepository.searchRestaurant(query);
    notifyListeners();
  }
}