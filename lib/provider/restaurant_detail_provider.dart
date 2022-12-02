import 'package:flutter/material.dart';

import '../domain/entity/restaurant/add_or_remove_restaurant_to_favorite_response.dart';
import '../domain/entity/restaurant/restaurant.dart';
import '../domain/entity/restaurant/restaurant_detail.dart';
import '../misc/load_data_result.dart';
import '../repository/restaurantrepository/restaurant_repository.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantRepository restaurantRepository;
  final String restaurantId;

  LoadDataResult<RestaurantDetail> _restaurantDetailLoadDataResult = NoLoadDataResult<RestaurantDetail>();
  LoadDataResult<RestaurantDetail> get restaurantDetailLoadDataResult => _restaurantDetailLoadDataResult;

  LoadDataResult<bool> _isMarkedAsFavoriteRestaurantLoadDataResult = NoLoadDataResult<bool>();
  LoadDataResult<bool> get isMarkedAsFavoriteRestaurantLoadDataResult => _isMarkedAsFavoriteRestaurantLoadDataResult;

  bool hasChangedFavoriteRestaurant = false;

  RestaurantDetailProvider({required this.restaurantRepository, required this.restaurantId}) {
    loadRestaurantList();
  }

  void loadRestaurantList() async {
    _restaurantDetailLoadDataResult = IsLoadingLoadDataResult<RestaurantDetail>();
    notifyListeners();
    _restaurantDetailLoadDataResult = await restaurantRepository.getRestaurantDetail(restaurantId);
    notifyListeners();
    if (_restaurantDetailLoadDataResult is SuccessLoadDataResult<RestaurantDetail>) {
      _isMarkedAsFavoriteRestaurantLoadDataResult = IsLoadingLoadDataResult<bool>();
      notifyListeners();
      _isMarkedAsFavoriteRestaurantLoadDataResult = await restaurantRepository.isMarkedAsFavoriteRestaurant(restaurantId);
      notifyListeners();
    }
  }

  void addOrRemoveRestaurantToFavorite() async {
    if (_restaurantDetailLoadDataResult is SuccessLoadDataResult<RestaurantDetail>) {
      Restaurant restaurant = (_restaurantDetailLoadDataResult as SuccessLoadDataResult<RestaurantDetail>).value;
      _isMarkedAsFavoriteRestaurantLoadDataResult = IsLoadingLoadDataResult<bool>();
      notifyListeners();
      LoadDataResult<AddOrRemoveRestaurantToFavoriteResponse> addOrRemoveRestaurantToFavoriteLoadDataResult = await restaurantRepository.addOrRemoveRestaurantToFavorite(restaurantId);
      if (addOrRemoveRestaurantToFavoriteLoadDataResult is SuccessLoadDataResult<AddOrRemoveRestaurantToFavoriteResponse>) {
        _isMarkedAsFavoriteRestaurantLoadDataResult = SuccessLoadDataResult<bool>(value: addOrRemoveRestaurantToFavoriteLoadDataResult.value.result);
      }
      notifyListeners();
    }
  }
}