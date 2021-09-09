import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_search.dart'
    as resSearch;
import 'package:restaurant_app2/provider/restaurant_list_provider.dart';
import 'package:restaurant_app2/widgets/no_internet.dart';
import 'package:restaurant_app2/widgets/restaurant_card.dart';
import 'package:restaurant_app2/widgets/restaurant_search_card.dart';

class RestaurantOverviewScreen extends StatefulWidget {
  static const routeName = '/list';

  @override
  _RestaurantOverviewScreenState createState() =>
      _RestaurantOverviewScreenState();
}

class _RestaurantOverviewScreenState extends State<RestaurantOverviewScreen> {
  final GlobalKey globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _textSearchController = TextEditingController();
  bool _isSearching = false;
  List<resSearch.Restaurant> searchResult = [];

  @override
  void initState() {
    _isSearching = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _textSearchController.dispose();
  }

  _RestaurantOverviewScreenState() {
    _textSearchController.addListener(() {
      if (_textSearchController.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              toolbarHeight: 60,
              elevation: 0,
              pinned: true,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/sliver-back.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: primaryColor.withOpacity(0.7),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rest\'O',
                          style: TextStyle(
                            fontFamily: 'Herbarium',
                            fontSize: 65,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: myTextTheme.subtitle1,
                          controller: _textSearchController,
                          onChanged: (value) {
                            searchOperation(value);
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            contentPadding: EdgeInsets.all(4.0),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(Icons.search, color: purple1),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ];
        },
        body: _buildList(),
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(
            child: CircularProgressIndicator(
              color: primaryColor,
              backgroundColor: secondaryColor,
            ),
          );
        } else if (state.state == ResultState.HasData) {
          if (_isSearching) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                return RestaurantSearchCard(resto: searchResult[index]);
              },
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.restaurants.restaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                    resto: state.restaurants.restaurants[index]);
              },
            );
          }
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.NoInternet) {
          return NoInternet();
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  void searchOperation(String query) async {
    final apiService = ApiService();
    // searchResult.clear();
    if (_isSearching != null) {
      try {
        final List<resSearch.Restaurant> restaurants =
            await apiService.searchRestaurant(query);
        searchResult.clear();
        for (var r in restaurants) {
          searchResult.add(r);
        }
      } catch (e) {
        print('Error --> $e');
      }
    }
  }
}
