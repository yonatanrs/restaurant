import '../../domain/entity/restaurant/restaurant.dart';

extension RestaurantExt on Restaurant {
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}

extension RestaurantMapJsonExt on Map<String, dynamic> {
  Restaurant fromJson() => Restaurant(
    id: this["id"],
    name: this["name"],
    description: this["description"],
    pictureId: this["pictureId"],
    city: this["city"],
    rating: this["rating"]
  );
}