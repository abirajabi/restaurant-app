import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/provider/restaurant_list_provider.dart'
    as resList;
import 'package:restaurant_app2/provider/search_provider.dart';
import 'package:restaurant_app2/widgets/center_message.dart';
import 'package:restaurant_app2/widgets/no_internet.dart';
import 'package:restaurant_app2/widgets/restaurant_card.dart';
import 'package:restaurant_app2/widgets/restaurant_search_card.dart';
import 'package:restaurant_app2/widgets/search_not_found.dart';
import 'package:sizer/sizer.dart';

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
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _textSearchController.addListener(_toggleSearchStatus);
  }

  void _toggleSearchStatus() {
    if (_textSearchController.text.isEmpty) {
      setState(() {
        _isSearching = false;
      });
    } else {
      setState(() {
        _isSearching = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _textSearchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          SearchProvider(apiService: ApiService(), query: searchText),
      child: Scaffold(
        backgroundColor: Colors.white,
        key: globalKey,
        body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 30.h,
                toolbarHeight: 7.h,
                elevation: 0,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: _searchBar(context),
                  titlePadding: EdgeInsets.symmetric(vertical: 1.h),
                  centerTitle: true,
                  background: Stack(
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Rest\'O',
                              style: TextStyle(
                                fontFamily: 'Herbarium',
                                fontSize: 32.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Find the best restaurants around you',
                              style: TextStyle(
                                  fontSize: myTextTheme.bodyText2!.fontSize,
                                  fontFamily: myTextTheme.bodyText2!.fontFamily,
                                  fontWeight: myTextTheme.bodyText2!.fontWeight,
                                  letterSpacing:
                                      myTextTheme.bodyText2!.letterSpacing,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: _buildList(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _isSearching
                  ? Consumer<SearchProvider>(
                      builder: (context, state, child) {
                        if (state.state == ResultState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.state == ResultState.NoData) {
                          return SearchNotFound();
                        } else if (state.state == ResultState.NoInternet) {
                          return NoInternet();
                        } else if (state.state == ResultState.Error) {
                          return CenterMessage(message: state.message);
                        } else if (state.state == ResultState.HasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.searchResult.founded,
                            itemBuilder: (context, index) {
                              return RestaurantSearchCard(
                                  resto: state.searchResult.restaurants[index]);
                            },
                          );
                        } else {
                          return CenterMessage(message: 'Unknown Error');
                        }
                      },
                    )
                  : Consumer<resList.RestaurantListProvider>(
                      builder: (context, state, child) {
                        if (state.state == ResultState.HasData) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.restaurants.restaurants.length,
                            itemBuilder: (context, index) {
                              return RestaurantCard(
                                  resto: state.restaurants.restaurants[index]);
                            },
                          );
                        } else if (state.state == ResultState.Loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.state == ResultState.NoData) {
                          return CenterMessage(message: state.message);
                        } else if (state.state == ResultState.NoInternet) {
                          return NoInternet();
                        } else if (state.state == ResultState.Error) {
                          return CenterMessage(message: state.message);
                        } else {
                          return CenterMessage(message: state.message);
                        }
                      },
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _searchBar(BuildContext ctx) {
    return LayoutBuilder(
      builder: (ctx, _) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
          height: 4.h,
          transformAlignment: Alignment.bottomCenter,
          child: TextFormField(
            style: TextStyle(fontSize: 9.5.sp),
            controller: _textSearchController,
            maxLines: 1,
            onChanged: (value) {
              searchText = value;
              Provider.of<SearchProvider>(ctx, listen: false)
                  .fetchSearchResult(searchText);
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.zero,
              isDense: true,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Search here',
              hintStyle: TextStyle(
                fontSize: 9.5.sp,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: purple1, width: 1.0),
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
