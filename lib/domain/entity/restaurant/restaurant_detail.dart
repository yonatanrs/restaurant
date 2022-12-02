import '../menu/group_menu_list.dart';
import '../menu/menu_list.dart';
import 'restaurant.dart';

class RestaurantDetail extends Restaurant {
  MenuList menuList;
  List<GroupMenuList> groupMenuList;

  RestaurantDetail({
    required String id,
    required String name,
    required String description,
    required String pictureId,
    required String city,
    required double rating,
    required this.menuList,
    required this.groupMenuList
  }) : super(
    id: id,
    name: name,
    description: description,
    pictureId: pictureId,
    city: city,
    rating: rating
  );
}