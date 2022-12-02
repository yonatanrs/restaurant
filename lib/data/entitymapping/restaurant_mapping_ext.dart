import 'package:dio/dio.dart';

import '../../domain/entity/menu/drink.dart';
import '../../domain/entity/menu/food.dart';
import '../../domain/entity/menu/group_menu_list.dart';
import '../../domain/entity/menu/menu.dart';
import '../../domain/entity/menu/menu_list.dart';
import '../../domain/entity/restaurant/restaurant.dart';
import '../../domain/entity/restaurant/restaurant_detail.dart';
import '../../domain/entity/restaurant/restaurant_search_response.dart';
import '../../misc/error/not_found_error.dart';
import '../../misc/response_wrapper.dart';

extension RestaurantMappingExt on Response<dynamic> {
  List<Restaurant> mapFromResponseToRestaurantList() {
    print("Data: ${this.data}, data type: ${this.data.runtimeType}");
    return data['restaurants'].map<Restaurant>((restaurantResponse) => ResponseWrapper(restaurantResponse).mapFromResponseToRestaurant()).toList();
  }

  RestaurantDetail mapFromResponseToRestaurantDetail() {
    return ResponseWrapper(data['restaurant']).mapFromResponseToRestaurantDetail();
  }

  RestaurantSearchResponse mapFromResponseToRestaurantSearchResponse() {
    int founded = data['founded'];
    if (founded == 0) {
      throw NotFoundError(message: "Restaurant that you want to search is not found.");
    }
    return RestaurantSearchResponse(
      count: founded,
      restaurantSearchResultList: data['restaurants'].map<Restaurant>((restaurantResponse) => ResponseWrapper(restaurantResponse).mapFromResponseToRestaurant()).toList(),
    );
  }
}

extension RestaurantMappingDetailExt on ResponseWrapper {
  Restaurant mapFromResponseToRestaurant() {
    dynamic ratingJson = response["rating"];
    double rating = ratingJson is int ? ratingJson.toDouble() : ratingJson;
    return Restaurant(
      id: response["id"],
      name: response["name"],
      description: response["description"],
      pictureId: response["pictureId"],
      city: response["city"],
      rating: rating,
    );
  }

  RestaurantDetail mapFromResponseToRestaurantDetail() {
    dynamic menuJson = response["menus"];
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
    Restaurant restaurant = mapFromResponseToRestaurant();
    return RestaurantDetail(
      id: restaurant.id,
      name: restaurant.name,
      description: restaurant.description,
      pictureId: restaurant.pictureId,
      city: restaurant.city,
      rating: restaurant.rating,
      menuList: MenuList(menuContentList: menuContentList),
      groupMenuList: groupMenuList
    );
  }
}