import 'dart:convert';

import 'package:flutter/services.dart';

import '../../../domain/entity/menu/drink.dart';
import '../../../domain/entity/menu/food.dart';
import '../../../domain/entity/menu/group_menu_list.dart';
import '../../../domain/entity/menu/menu.dart';
import '../../../domain/entity/menu/menu_list.dart';
import '../../../domain/entity/restaurant/add_or_remove_restaurant_to_favorite_response.dart';
import '../../../domain/entity/restaurant/restaurant.dart';
import '../../../domain/entity/restaurant/restaurant_detail.dart';
import '../../../domain/entity/restaurant/restaurant_search_response.dart';
import '../../../misc/error/not_found_error.dart';
import 'restaurant_data_source.dart';

class DummyRestaurantDataSource implements RestaurantDataSource {
  Future<List<RestaurantDetail>> _getRestaurantDetailList() async {
    String localRestaurantString = await rootBundle.loadString('assets/local_restaurant.json');
    dynamic localRestaurantJson = json.decode(localRestaurantString);
    if (localRestaurantJson is Map<String, dynamic>) {
      if (localRestaurantJson.containsKey("restaurants")) {
        dynamic restaurantJson = localRestaurantJson["restaurants"];
        if (restaurantJson is List) {
          List<RestaurantDetail> restaurantDetailResult = [];
          for (var singleRestaurantJson in restaurantJson) {
            dynamic menuJson = singleRestaurantJson["menus"];
            List<Menu> menuContentList = [];
            List<GroupMenuList> groupMenuList = [];
            if (menuJson is Map<String, dynamic>) {
              menuJson.forEach((key, value) {
                if (key == "foods" && value is List) {
                  List<Menu> foodMenuContentList = [];
                  for (var singleFoodJson in value) {
                    if (singleFoodJson is Map<String, dynamic>) {
                      Food food = Food(name: singleFoodJson["name"]);
                      foodMenuContentList.add(food);
                      menuContentList.add(food);
                    }
                  }
                  groupMenuList.add(
                    GroupMenuList(
                      groupName: 'Foods',
                      menuContentList: foodMenuContentList,
                    )
                  );
                } else if (key == "drinks" && value is List) {
                  List<Menu> drinkMenuContentList = [];
                  for (var singleDrinkJson in value) {
                    if (singleDrinkJson is Map<String, dynamic>) {
                      Drink drink = Drink(name: singleDrinkJson["name"]);
                      drinkMenuContentList.add(drink);
                      menuContentList.add(drink);
                    }
                  }
                  groupMenuList.add(
                    GroupMenuList(
                      groupName: 'Drinks',
                      menuContentList: drinkMenuContentList,
                    )
                  );
                }
              });
            }
            dynamic ratingJson = singleRestaurantJson["rating"];
            double rating = ratingJson is int ? ratingJson.toDouble() : ratingJson;
            RestaurantDetail restaurantDetail = RestaurantDetail(
              id: singleRestaurantJson["id"],
              name: singleRestaurantJson["name"],
              description: singleRestaurantJson["description"],
              pictureId: singleRestaurantJson["pictureId"],
              city: singleRestaurantJson["city"],
              rating: rating,
              menuList: MenuList(menuContentList: menuContentList),
              groupMenuList: groupMenuList
            );
            restaurantDetailResult.add(restaurantDetail);
          }
          return restaurantDetailResult;
        }
      }
    }
    return [];
  }

  @override
  Future<List<Restaurant>> getRestaurantList() async {
    await Future.delayed(const Duration(seconds: 1));
    return _getRestaurantDetailList();
  }

  @override
  Future<RestaurantDetail> getRestaurantDetail(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));
    List<RestaurantDetail> restaurantDetailList = await _getRestaurantDetailList();
    Iterable<RestaurantDetail> restaurantDetailIterable = restaurantDetailList.where((restaurantDetail) => restaurantDetail.id == restaurantId);
    if (restaurantDetailIterable.isNotEmpty) {
      RestaurantDetail restaurantDetail = restaurantDetailIterable.first;
      return restaurantDetail;
    } else {
      throw NotFoundError(message: "Restaurant that you want to see detail is not found.");
    }
  }

  @override
  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    List<Restaurant> restaurantList = await _getRestaurantDetailList();
    Iterable<Restaurant> restaurantIterable = restaurantList.where((restaurant) => restaurant.name.contains(query));
    if (restaurantIterable.isNotEmpty) {
      return RestaurantSearchResponse(
        count: restaurantIterable.length,
        restaurantSearchResultList: restaurantIterable.toList()
      );
    } else {
      throw NotFoundError(message: "Restaurant that you want to search is not found.");
    }
  }

  @override
  Future<List<Restaurant>> getFavoriteRestaurant() async {
    await Future.delayed(const Duration(seconds: 1));
    throw NotFoundError(message: "No favorite restaurant");
  }

  @override
  Future<AddOrRemoveRestaurantToFavoriteResponse> addOrRemoveRestaurantToFavorite(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));
    return AddOrRemoveRestaurantToFavoriteResponse(result: true);
  }

  @override
  Future<bool> isMarkedAsFavoriteRestaurant(String restaurantId) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}