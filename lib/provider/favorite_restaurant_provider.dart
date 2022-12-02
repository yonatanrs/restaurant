import 'package:flutter/material.dart';

import '../domain/entity/restaurant/restaurant.dart';
import '../misc/load_data_result.dart';
import '../repository/restaurantrepository/restaurant_repository.dart';

class FavoriteRestaurantProvider extends ChangeNotifier {
  final RestaurantRepository restaurantRepository;

  LoadDataResult<List<Restaurant>> _restaurantLoadDataResult = NoLoadDataResult<List<Restaurant>>();
  LoadDataResult<List<Restaurant>> get restaurantLoadDataResult => _restaurantLoadDataResult;

  FavoriteRestaurantProvider({required this.restaurantRepository}) {
    loadRestaurantList();
  }

  void loadRestaurantList() async {
    _restaurantLoadDataResult = IsLoadingLoadDataResult<List<Restaurant>>();
    notifyListeners();
    _restaurantLoadDataResult = await restaurantRepository.getFavoriteRestaurant();
    notifyListeners();
  }
}