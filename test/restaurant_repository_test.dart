import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:restaurant/data/datasource/restaurantdatasource/default_restaurant_data_source.dart';
import 'package:restaurant/data/datasource/restaurantdatasource/restaurant_data_source.dart';
import 'package:restaurant/domain/entity/restaurant/restaurant.dart';
import 'package:restaurant/domain/entity/restaurant/restaurant_detail.dart';
import 'package:restaurant/domain/entity/restaurant/restaurant_search_response.dart';
import 'package:restaurant/misc/http_client.dart';
import 'package:restaurant/misc/load_data_result.dart';
import 'package:restaurant/repository/restaurantrepository/default_restaurant_repository.dart';
import 'package:restaurant/repository/restaurantrepository/restaurant_repository.dart';

void main() {
  group('Restaurant General Repository Test', () {
    late RestaurantDataSource restaurantDataSource;
    late RestaurantRepository restaurantRepository;
    late Dio dio;
    late DioAdapter dioAdapter;

    setUp(() {
      dio = DioHttpClient.of();
      dioAdapter = DioAdapter(dio: dio);
      restaurantDataSource = DefaultRestaurantDataSource(dio: dio);
      restaurantRepository = DefaultRestaurantRepository(restaurantDataSource: restaurantDataSource);
    });

    test('get restaurant list', () async {
      dioAdapter.onGet(
        "/list",
        (server) => server.reply(
          200,
          jsonDecode("{\"error\":false,\"message\":\"success\",\"count\":20,\"restaurants\":[{\"id\":\"rqdv5juczeskfw1e867\",\"name\":\"Melting Pot\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"14\",\"city\":\"Medan\",\"rating\":4.2},{\"id\":\"s1knt6za9kkfw1e867\",\"name\":\"Kafe Kita\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"25\",\"city\":\"Gorontalo\",\"rating\":4},{\"id\":\"w9pga3s2tubkfw1e867\",\"name\":\"Bring Your Phone Cafe\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"03\",\"city\":\"Surabaya\",\"rating\":4.2},{\"id\":\"uewq1zg2zlskfw1e867\",\"name\":\"Kafein\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"15\",\"city\":\"Aceh\",\"rating\":4.6},{\"id\":\"ygewwl55ktckfw1e867\",\"name\":\"Istana Emas\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"05\",\"city\":\"Balikpapan\",\"rating\":4.5},{\"id\":\"fnfn8mytkpmkfw1e867\",\"name\":\"Makan mudah\",\"description\":\"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.\",\"pictureId\":\"22\",\"city\":\"Medan\",\"rating\":3.7},{\"id\":\"dwg2wt3is19kfw1e867\",\"name\":\"Drinky Squash\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"18\",\"city\":\"Surabaya\",\"rating\":3.9},{\"id\":\"6u9lf7okjh9kfw1e867\",\"name\":\"Ampiran Kota\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"35\",\"city\":\"Balikpapan\",\"rating\":4.1},{\"id\":\"zvf11c0sukfw1e867\",\"name\":\"Gigitan Cepat\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"38\",\"city\":\"Bali\",\"rating\":4},{\"id\":\"ughslf146iqkfw1e867\",\"name\":\"Tempat Siang Hari\",\"description\":\"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.\",\"pictureId\":\"10\",\"city\":\"Surabaya\",\"rating\":4.4},{\"id\":\"w7jca3irwykfw1e867\",\"name\":\"Fairy Cafe\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"24\",\"city\":\"Surabaya\",\"rating\":5},{\"id\":\"8maika7giinkfw1e867\",\"name\":\"Rumah Senja\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"23\",\"city\":\"Bandung\",\"rating\":3.9},{\"id\":\"e1elb86snf8kfw1e867\",\"name\":\"Saya Suka\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"34\",\"city\":\"Bandung\",\"rating\":4.3},{\"id\":\"69ahsy71a5gkfw1e867\",\"name\":\"Hub Grubber\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"32\",\"city\":\"Balikpapan\",\"rating\":3.8},{\"id\":\"ateyf7m737ekfw1e867\",\"name\":\"Kafe Cemara\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"27\",\"city\":\"Ternate\",\"rating\":3.6},{\"id\":\"02hfwn4bh8uzkfw1e867\",\"name\":\"Manis Asam Kafe\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"21\",\"city\":\"Malang\",\"rating\":4.6},{\"id\":\"p06p0wr8eedkfw1e867\",\"name\":\"Run The Gun\",\"description\":\"But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure.\",\"pictureId\":\"30\",\"city\":\"Aceh\",\"rating\":3.7},{\"id\":\"uqzwm2m981kfw1e867\",\"name\":\"Bobby\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"19\",\"city\":\"Ternate\",\"rating\":4.7},{\"id\":\"dy62fuwe6w8kfw1e867\",\"name\":\"Pangsit Express\",\"description\":\"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,\",\"pictureId\":\"43\",\"city\":\"Surabaya\",\"rating\":4.8},{\"id\":\"vfsqv0t48jkfw1e867\",\"name\":\"Gigitan Makro\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"04\",\"city\":\"Surabaya\",\"rating\":4.9}]}")
        ),
        data: null,
        queryParameters: {},
        headers: {},
      );
      LoadDataResult<List<Restaurant>> restaurantLoadDataResult = await restaurantRepository.getRestaurantList();
      expect(restaurantLoadDataResult is SuccessLoadDataResult<List<Restaurant>>, true);
      List<Restaurant> restaurantList = (restaurantLoadDataResult as SuccessLoadDataResult<List<Restaurant>>).value;
      expect(restaurantList.length, 20);
    });

    test('get restaurant detail', () async {
      String restaurantId = "rqdv5juczeskfw1e867";
      dioAdapter.onGet(
        "/detail/$restaurantId",
        (server) => server.reply(
          200,
          jsonDecode("{\"error\":false,\"message\":\"success\",\"restaurant\":{\"id\":\"rqdv5juczeskfw1e867\",\"name\":\"Melting Pot\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"city\":\"Medan\",\"address\":\"Jln. Pandeglang no 19\",\"pictureId\":\"14\",\"rating\":4.2,\"categories\":[{\"name\":\"Italia\"},{\"name\":\"Modern\"}],\"menus\":{\"foods\":[{\"name\":\"Paket rosemary\"},{\"name\":\"Toastie salmon\"},{\"name\":\"Bebek crepes\"},{\"name\":\"Salad lengkeng\"}],\"drinks\":[{\"name\":\"Es krim\"},{\"name\":\"Sirup\"},{\"name\":\"Jus apel\"},{\"name\":\"Jus jeruk\"},{\"name\":\"Coklat panas\"},{\"name\":\"Air\"},{\"name\":\"Es kopi\"},{\"name\":\"Jus alpukat\"},{\"name\":\"Jus mangga\"},{\"name\":\"Teh manis\"},{\"name\":\"Kopi espresso\"},{\"name\":\"Minuman soda\"},{\"name\":\"Jus tomat\"}]},\"customerReviews\":[{\"name\":\"Ahmad\",\"review\":\"Tidak rekomendasi untuk pelajar!\",\"date\":\"13 November 2019\"},{\"name\":\"gfgf\",\"review\":\"gfgfgf\",\"date\":\"24 November 2022\"},{\"name\":\"Bagas\",\"review\":\"Enak\",\"date\":\"24 November 2022\"},{\"name\":\"fsdf\",\"review\":\"asdfdsa\",\"date\":\"24 November 2022\"},{\"name\":\"Bagas\",\"review\":\"Enak\",\"date\":\"24 November 2022\"},{\"name\":\"fdgdfg\",\"review\":\"gfdgfdgd\",\"date\":\"24 November 2022\"},{\"name\":\"Bagas\",\"review\":\"Enak\",\"date\":\"24 November 2022\"},{\"name\":\"Jaka\",\"review\":\"Enak\",\"date\":\"24 November 2022\"},{\"name\":\"fsdf\",\"review\":\"dsafsdaf\",\"date\":\"24 November 2022\"},{\"name\":\"sdf\",\"review\":\"fdsf\",\"date\":\"24 November 2022\"}]}}")
        ),
        data: null,
        queryParameters: {},
        headers: {},
      );
      LoadDataResult<RestaurantDetail> restaurantDetailLoadDataResult = await restaurantRepository.getRestaurantDetail(restaurantId);
      expect(restaurantDetailLoadDataResult is SuccessLoadDataResult<RestaurantDetail>, true);
      RestaurantDetail restaurantList = (restaurantDetailLoadDataResult as SuccessLoadDataResult<RestaurantDetail>).value;
      expect(restaurantList.id, "rqdv5juczeskfw1e867");
      expect(restaurantList.name, "Melting Pot");
    });

    test('search restaurant', () async {
      String searchText = "Melting Pot";
      dioAdapter.onGet(
        "/search",
        (server) => server.reply(
          200,
          jsonDecode("{\"error\":false,\"founded\":1,\"restaurants\":[{\"id\":\"rqdv5juczeskfw1e867\",\"name\":\"Melting Pot\",\"description\":\"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.\",\"pictureId\":\"14\",\"city\":\"Medan\",\"rating\":4.2}]}")
        ),
        data: null,
        queryParameters: {"q": searchText},
        headers: {},
      );
      LoadDataResult<RestaurantSearchResponse> restaurantSearchResponseLoadDataResult = await restaurantRepository.searchRestaurant(searchText);
      expect(restaurantSearchResponseLoadDataResult is SuccessLoadDataResult<RestaurantSearchResponse>, true);
      RestaurantSearchResponse restaurantSearchResponse = (restaurantSearchResponseLoadDataResult as SuccessLoadDataResult<RestaurantSearchResponse>).value;
      expect(restaurantSearchResponse.count, restaurantSearchResponse.restaurantSearchResultList.length);
      expect(restaurantSearchResponse.restaurantSearchResultList.where((restaurant) => restaurant.id == "rqdv5juczeskfw1e867" && restaurant.name == "Melting Pot").length, 1);
    });
  });
}