import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/provider/restaurant_list_provider.dart';
import 'package:restaurant_app2/widgets/restaurant_card.dart';

class RestaurantOverviewScreen extends StatefulWidget {
  static const routeName = '/list';

  @override
  _RestaurantOverviewScreenState createState() =>
      _RestaurantOverviewScreenState();
}

class _RestaurantOverviewScreenState extends State<RestaurantOverviewScreen> {
  final TextEditingController _textSearchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _textSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: primaryColor.withOpacity(0.5),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: myTextTheme.subtitle1,
                          controller: _textSearchController,
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
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.restaurants.restaurants.length,
            itemBuilder: (context, index) {
              return RestaurantCard(
                  resto: state.restaurants.restaurants[index]);
            },
          );
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }
}
