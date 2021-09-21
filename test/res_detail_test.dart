import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_detail.dart';

import 'res_detail_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchRestaurantDetailById', () {
    test(
      'return RestaurantDetail when http call completes successfully',
      () async {
        final client = MockClient();

        when(client.get(Uri.parse(
                'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
            .thenAnswer((_) async => await http.Response(
                '{"error":false,"message":"success","restaurant":{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","city":"Medan","address":"Jln. Pandeglang no 19","pictureId":"14","categories":[{"name":"Italia"},{"name":"Modern"}],"menus":{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"},{"name":"Bebek crepes"},{"name":"Salad lengkeng"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"},{"name":"Jus apel"},{"name":"Jus jeruk"},{"name":"Coklat panas"},{"name":"Air"},{"name":"Es kopi"},{"name":"Jus alpukat"},{"name":"Jus mangga"},{"name":"Teh manis"},{"name":"Kopi espresso"},{"name":"Minuman soda"},{"name":"Jus tomat"}]},"rating":4.2,"customerReviews":[{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"},{"name":"Test review","review":"Test review","date":"21 September 2021"},{"name":"Rajabi","review":"Test get.back()","date":"21 September 2021"},{"name":"dimas","review":"bagus sekali","date":"21 September 2021"}]}}',
                200));

        expect(await ApiService().restaurantDetailById('rqdv5juczeskfw1e867'),
            isA<RestaurantDetail>());
      },
    );

    test('throw exception if http call completes with an error', () {
      final client = MockClient();

      when(client.get(Uri.parse(
              'https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867')))
          .thenAnswer((_) async => await http.Response(
              'Failed to get the detail of restaurant.', 404));

      expect(ApiService().restaurantDetailById('rqdv5juczeskfw1e86'),
          throwsException);
    });
  });
}
