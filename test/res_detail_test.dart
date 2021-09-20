import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_detail.dart';

void main() {
  test('Test JSON parsing on restaurant detail model', () async {
    final ApiService apiService = ApiService();

    final actual = await apiService.restaurantDetailById('rqdv5juczeskfw1e867');
    final actualRes = actual.restaurant;

    Restaurant expected = Restaurant(
      id: 'rqdv5juczeskfw1e867',
      name: "Melting Pot",
      rating: 4.2,
      description:
          'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.',
      city: 'Medan',
      categories: [
        Category(name: 'Italia'),
        Category(name: 'Modern'),
      ],
      menus: Menus(
        foods: [
          Category(name: 'Paket rosemary'),
          Category(name: 'Toastie salmon'),
          Category(name: 'Bebek crepes'),
          Category(name: 'Salad lengkeng'),
        ],
        drinks: [
          Category(name: 'Es krim'),
          Category(name: 'Sirup'),
          Category(name: 'Jus apel'),
          Category(name: 'Jus apel'),
          Category(name: 'Jus jeruk'),
          Category(name: 'Coklat panas'),
          Category(name: 'Air'),
          Category(name: 'Jus alpukat'),
          Category(name: 'Jus mangga'),
          Category(name: 'Teh manis'),
          Category(name: 'Kopi espresso'),
          Category(name: 'Minuman soda'),
          Category(name: 'Jus tomat'),
        ],
      ),
      pictureId: '14',
      address: 'Jln. Pandeglang no 19',
      customerReviews: [
        CustomerReview(
            date: '13 November 2019',
            review: 'Tidak rekomendasi untuk pelajar!',
            name: 'Ahmad'),
      ],
    );

    expect(actualRes.id, expected.id);
    expect(actualRes.name, expected.name);
    expect(actualRes.pictureId, expected.pictureId);
    expect(actualRes.rating, expected.rating);
    expect(actualRes.description, expected.description);
    expect(actualRes.city, expected.city);
    expect(actualRes.pictureId, expected.pictureId);
    expect(actualRes.address, expected.address);
    expect(actualRes.menus, isA<Menus>());
    expect(actualRes.categories, isA<List<Category>>());
    expect(actualRes.categories.length, expected.categories.length);

    /// Panjang customer review dapat berubah karenanya test gagal
    /// Di sini diambil yang statis saja yaitu elemen pertama
    expect(actualRes.customerReviews.length, expected.customerReviews.length);
  });
}
