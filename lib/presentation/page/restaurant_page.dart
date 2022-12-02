import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/restaurant/restaurant.dart';
import '../../misc/injector.dart';
import '../../provider/restaurant_provider.dart';
import '../widget/loaddataresultimplementer/load_data_result_implementer.dart';
import '../widget/restaurant_item.dart';
import 'favorite_restaurant_page.dart';
import 'restaurant_search_page.dart';
import 'restaurant_setting_page.dart';

class RestaurantPage extends StatelessWidget {
  const RestaurantPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => const RestaurantSearchPage()),
            )
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => const FavoriteRestaurantPage()),
            )
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => const RestaurantSettingPage()),
            )
          )
        ],
      ),
      body: ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(restaurantRepository: Injector.restaurantRepository),
        child: Consumer<RestaurantProvider>(
          builder: (context, restaurantProvider, widget) => LoadDataResultImplementer<List<Restaurant>>(
            loadDataResult: restaurantProvider.restaurantLoadDataResult,
            errorProvider: Injector.errorProvider,
            onSuccessLoadDataResultWidget: (restaurantList) {
              return ListView.builder(
                itemCount: restaurantList.length,
                itemBuilder: (context, index) => RestaurantItem(restaurant: restaurantList[index]),
              );
            }
          )
        )
      )
    );
  }
}