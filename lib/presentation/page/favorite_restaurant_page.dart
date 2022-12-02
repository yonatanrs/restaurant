import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/restaurant/restaurant.dart';
import '../../misc/injector.dart';
import '../../provider/favorite_restaurant_provider.dart';
import '../widget/loaddataresultimplementer/load_data_result_implementer.dart';
import '../widget/restaurant_item.dart';

class FavoriteRestaurantPage extends StatelessWidget {
  const FavoriteRestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Restaurant"),
      ),
      body: ChangeNotifierProvider<FavoriteRestaurantProvider>(
        create: (_) => FavoriteRestaurantProvider(restaurantRepository: Injector.restaurantRepository),
        child: Consumer<FavoriteRestaurantProvider>(
          builder: (context, restaurantProvider, widget) => LoadDataResultImplementer<List<Restaurant>>(
            loadDataResult: restaurantProvider.restaurantLoadDataResult,
            errorProvider: Injector.errorProvider,
            onSuccessLoadDataResultWidget: (restaurantList) {
              return ListView.builder(
                itemCount: restaurantList.length,
                itemBuilder: (context, index) => RestaurantItem(
                  restaurant: restaurantList[index],
                  onTap: (onNavigateToFavoriteRestaurant) async {
                    bool? result = await onNavigateToFavoriteRestaurant();
                    if (result != null) {
                      if (result) {
                        restaurantProvider.loadRestaurantList();
                      }
                    }
                  }
                ),
              );
            }
          )
        )
      )
    );
  }
}