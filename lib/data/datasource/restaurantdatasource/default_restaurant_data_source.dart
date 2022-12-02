import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:restaurant/data/entitymapping/restaurant_mapping_ext.dart';
import 'package:restaurant/misc/ext/future_ext.dart';

import '../../../domain/entity/restaurant/add_or_remove_restaurant_to_favorite_response.dart';
import '../../../domain/entity/restaurant/restaurant.dart';
import '../../../domain/entity/restaurant/restaurant_detail.dart';
import '../../../domain/entity/restaurant/restaurant_search_response.dart';
import '../../../misc/constant.dart';
import '../../../misc/error/not_found_error.dart';
import '../../hiveentity/restaurant_hive_entity.dart';
import 'restaurant_data_source.dart';

class DefaultRestaurantDataSource implements RestaurantDataSource {
  final Dio dio;

  DefaultRestaurantDataSource({
    required this.dio
  });

  @override
  Future<List<Restaurant>> getRestaurantList() {
    return dio.get("/list").map(onMap: (value) => value.mapFromResponseToRestaurantList());
  }

  @override
  Future<RestaurantDetail> getRestaurantDetail(String restaurantId) {
    return dio.get("/detail/$restaurantId").map(onMap: (value) => value.mapFromResponseToRestaurantDetail());
  }

  @override
  Future<RestaurantSearchResponse> searchRestaurant(String query) {
    return dio.get("/search", queryParameters: {"q": query}).map(onMap: (value) => value.mapFromResponseToRestaurantSearchResponse());
  }

  @override
  Future<List<Restaurant>> getFavoriteRestaurant() async {
    Box<RestaurantHiveEntity> box = await Hive.openBox<RestaurantHiveEntity>(Constant.textFavoriteRestaurantHiveTableKey);
    List<Restaurant> restaurant = box.values.map(
      (restaurantHiveEntity) => Restaurant(
        id: restaurantHiveEntity.id,
        name: restaurantHiveEntity.name,
        description: restaurantHiveEntity.description,
        pictureId: restaurantHiveEntity.pictureId,
        city: restaurantHiveEntity.city,
        rating: restaurantHiveEntity.rating
      )
    ).toList();
    await box.close();
    if (restaurant.isEmpty) {
      throw NotFoundError(message: "Your favorite restaurant is empty.");
    }
    return restaurant;
  }

  @override
  Future<AddOrRemoveRestaurantToFavoriteResponse> addOrRemoveRestaurantToFavorite(String restaurantId) async {
    RestaurantDetail restaurantDetail = await getRestaurantDetail(restaurantId);
    Box box = await Hive.openBox(Constant.textFavoriteRestaurantHiveTableKey);
    late final bool result;
    if (box.containsKey(restaurantId)) {
      await box.delete(restaurantId);
      result = false;
    } else {
      RestaurantHiveEntity restaurantHiveEntity = RestaurantHiveEntity()
        ..id = restaurantDetail.id
        ..name = restaurantDetail.name
        ..description = restaurantDetail.description
        ..pictureId = restaurantDetail.pictureId
        ..city = restaurantDetail.city
        ..rating = restaurantDetail.rating;
      await box.put(restaurantId, restaurantHiveEntity);
      result = true;
    }
    await box.close();
    return AddOrRemoveRestaurantToFavoriteResponse(result: result);
  }

  @override
  Future<bool> isMarkedAsFavoriteRestaurant(String restaurantId) async {
    Box box = await Hive.openBox(Constant.textFavoriteRestaurantHiveTableKey);
    bool result = box.containsKey(restaurantId);
    await box.close();
    return result;
  }
}