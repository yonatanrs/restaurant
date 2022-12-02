import 'package:hive/hive.dart';

part 'restaurant_hive_entity.g.dart';

@HiveType(typeId: 1)
class RestaurantHiveEntity {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String pictureId;

  @HiveField(4)
  late String city;

  @HiveField(5)
  late double rating;
}
