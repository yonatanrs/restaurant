import 'package:flutter/material.dart';
import 'package:restaurant/misc/picture_url_format_type.dart';

import '../../domain/entity/restaurant/restaurant.dart';
import '../../misc/string_util.dart';
import '../page/restaurant_detail_page.dart';
import 'modified_cached_network_image.dart';

class RestaurantItem extends StatelessWidget {
  final Restaurant restaurant;
  final void Function(Future<bool?> Function())? onTap;

  const RestaurantItem({
    Key? key,
    required this.restaurant,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<bool?> navigateToRestaurantDetailPage() async {
      return await Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => RestaurantDetailPage(restaurantId: restaurant.id))
      );
    }
    return Material(
      child: InkWell(
        onTap: onTap != null ? () => onTap!(navigateToRestaurantDetailPage) : navigateToRestaurantDetailPage,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: ModifiedCachedNetworkImage(
                      imageUrl: StringUtil.formatPictureUrl(restaurant.pictureId, PictureUrlFormatType.smallPictureResolution)
                    )
                  )
                ),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.name),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      const Icon(Icons.location_on_sharp),
                      const SizedBox(width: 5.0),
                      Text(restaurant.city)
                    ]
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star),
                      const SizedBox(width: 5.0),
                      Text(restaurant.rating.toString())
                    ]
                  )
                ]
              )
            ]
          ),
        ),
      ),
    );
  }
}