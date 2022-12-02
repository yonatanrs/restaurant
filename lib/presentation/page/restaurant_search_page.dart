import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/restaurant/restaurant_search_response.dart';
import '../../misc/injector.dart';
import '../../provider/restaurant_search_provider.dart';
import '../widget/loaddataresultimplementer/load_data_result_implementer.dart';
import '../widget/restaurant_item.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final TextEditingController _searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(restaurantRepository: Injector.restaurantRepository),
      child: Consumer<RestaurantSearchProvider>(
        builder: (context, restaurantSearchProvider, widget) => Scaffold(
          appBar: AppBar(
            title: TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              controller: _searchTextEditingController,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search Restaurant",
                hintStyle: TextStyle(color: Colors.white60),
                labelStyle: TextStyle(color: Colors.white60),
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                restaurantSearchProvider.searchRestaurantList(_searchTextEditingController.text);
              },
            ),
          ),
          body: LoadDataResultImplementer<RestaurantSearchResponse>(
            loadDataResult: restaurantSearchProvider.restaurantSearchResponseLoadDataResult,
            errorProvider: Injector.errorProvider,
            onSuccessLoadDataResultWidget: (restaurantList) {
              return ListView.builder(
                itemCount: restaurantList.restaurantSearchResultList.length,
                itemBuilder: (context, index) => RestaurantItem(restaurant: restaurantList.restaurantSearchResultList[index]),
              );
            }
          )
        )
      )
    );
  }
}