import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../misc/dialog_helper.dart';
import '../../misc/injector.dart';
import '../../misc/load_data_result.dart';
import '../../provider/restaurant_setting_provider.dart';
import '../widget/loaddataresultimplementer/load_data_result_implementer.dart';

class RestaurantSettingPage extends StatelessWidget {
  const RestaurantSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Setting"),
      ),
      body: ChangeNotifierProvider<RestaurantSettingProvider>(
        create: (_) => RestaurantSettingProvider(restaurantSettingRepository: Injector.restaurantSettingRepository),
        child: Consumer<RestaurantSettingProvider>(
          builder: (context, restaurantSettingProvider, widget) => LoadDataResultImplementer<bool>(
            loadDataResult: restaurantSettingProvider.receiveNotificationSettingResponseLoadDataResult,
            errorProvider: Injector.errorProvider,
            onSuccessLoadDataResultWidget: (restaurantList) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text("Receive recommendation restaurant notification every 11:00.")
                      ),
                      const SizedBox(width: 10),
                      Builder(
                        builder: (context) {
                          LoadDataResult<bool> receiveNotificationSettingResponseLoadDataResult = restaurantSettingProvider.receiveNotificationSettingResponseLoadDataResult;
                          if (receiveNotificationSettingResponseLoadDataResult is IsLoadingLoadDataResult<bool>) {
                            return const CircularProgressIndicator();
                          } else if (receiveNotificationSettingResponseLoadDataResult is SuccessLoadDataResult<bool>) {
                            return Switch.adaptive(
                              value: receiveNotificationSettingResponseLoadDataResult.value,
                              onChanged: (value) async {
                                if (Platform.isIOS) {
                                  DialogHelper.customDialog(context);
                                } else {
                                  restaurantSettingProvider.scheduledOrNotRestaurantRecommendation();
                                }
                              },
                            );
                          } else if (receiveNotificationSettingResponseLoadDataResult is FailedLoadDataResult<bool>) {
                            return const Icon(Icons.error);
                          } else {
                            return Container();
                          }
                        },
                      )
                    ]
                  ),
                )
              );
            }
          )
        )
      )
    );
  }
}