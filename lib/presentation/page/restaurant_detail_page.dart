import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entity/restaurant/restaurant_detail.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../misc/picture_url_format_type.dart';
import '../../misc/string_util.dart';
import '../../provider/restaurant_detail_provider.dart';
import '../widget/loaddataresultimplementer/load_data_result_implementer.dart';
import '../widget/modified_cached_network_image.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String restaurantId;

  const RestaurantDetailPage({Key? key, required this.restaurantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(
        restaurantRepository: Injector.restaurantRepository,
        restaurantId: restaurantId
      ),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, restaurantDetailProvider, widget) => WillPopScope(
          onWillPop: () async {
            if (restaurantDetailProvider.hasChangedFavoriteRestaurant) {
              Navigator.of(context).pop(restaurantDetailProvider.hasChangedFavoriteRestaurant);
              return false;
            }
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text("Restaurant Detail"),
            ),
            body: LoadDataResultImplementer<RestaurantDetail>(
              loadDataResult: restaurantDetailProvider.restaurantDetailLoadDataResult,
              errorProvider: Injector.errorProvider,
              onSuccessLoadDataResultWidget: (restaurantDetail) {
                List<Widget> menuRowWidget = [];
                for (var groupMenu in restaurantDetail.groupMenuList) {
                  List<Widget> menuGroupMemberWidget = [];
                  menuGroupMemberWidget.add(Text(groupMenu.groupName, style: const TextStyle(fontWeight: FontWeight.bold)));
                  for (var menu in groupMenu.menuContentList) {
                    menuGroupMemberWidget.add(Text("- ${menu.name}"));
                  }
                  menuRowWidget.add(
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: menuGroupMemberWidget
                      )
                    )
                  );
                }
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: AspectRatio(
                          aspectRatio: 16.0 / 9.0,
                          child: ClipRRect(
                            child: ModifiedCachedNetworkImage(
                              imageUrl: StringUtil.formatPictureUrl(restaurantDetail.pictureId, PictureUrlFormatType.mediumPictureResolution),
                            )
                          )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(restaurantDetail.name, style: const TextStyle(fontSize: 20)),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          const Icon(Icons.location_on_sharp),
                                          const SizedBox(width: 5.0),
                                          Text(restaurantDetail.city)
                                        ]
                                      ),
                                      const SizedBox(height: 5.0),
                                      Row(
                                        children: [
                                          const Icon(Icons.star),
                                          const SizedBox(width: 5.0),
                                          Text(restaurantDetail.rating.toString())
                                        ]
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Builder(
                                  builder: (context) {
                                    LoadDataResult<bool> isMarkedAsFavoriteRestaurantLoadDataResult = restaurantDetailProvider.isMarkedAsFavoriteRestaurantLoadDataResult;
                                    if (isMarkedAsFavoriteRestaurantLoadDataResult is IsLoadingLoadDataResult<bool>) {
                                      return const CircularProgressIndicator();
                                    } else if (isMarkedAsFavoriteRestaurantLoadDataResult is SuccessLoadDataResult<bool>){
                                      bool isMarkedAsFavoriteRestaurant = isMarkedAsFavoriteRestaurantLoadDataResult.value;
                                      return IconButton(
                                        icon: Icon(isMarkedAsFavoriteRestaurant ? Icons.favorite : Icons.favorite_border),
                                        onPressed: () {
                                          restaurantDetailProvider.addOrRemoveRestaurantToFavorite();
                                          restaurantDetailProvider.hasChangedFavoriteRestaurant = true;
                                        }
                                      );
                                    } else if (isMarkedAsFavoriteRestaurantLoadDataResult is FailedLoadDataResult<bool>) {
                                      return const Icon(Icons.error);
                                    } else {
                                      return Container();
                                    }
                                  }
                                )
                              ]
                            ),
                            const SizedBox(height: 10.0),
                            Text(restaurantDetail.description),
                            const SizedBox(height: 16.0),
                            const Text("Menu", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0)),
                            const SizedBox(height: 10.0),
                            if (menuRowWidget.isNotEmpty)
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: menuRowWidget
                              )
                          ]
                        ),
                      )
                    ]
                  ),
                );
              }
            )
          )
        )
      )
    );
  }
}