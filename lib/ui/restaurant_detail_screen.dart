import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_detail.dart';
import 'package:restaurant_app2/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app2/widgets/center_message.dart';
import 'package:restaurant_app2/widgets/no_internet.dart';

class RestaurantDetailScreen extends StatefulWidget {
  static final String routeName = '/detail';
  static final String _baseImageUrl =
      "https://restaurant-api.dicoding.dev/images/";
  late final ApiService apiService;

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    final String resId = ModalRoute.of(context)!.settings.arguments as String;
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) =>
          RestaurantDetailProvider(apiService: widget.apiService, resId: resId),
      child: Scaffold(
        body: Consumer<RestaurantDetailProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                  backgroundColor: secondaryColor,
                ),
              );
            } else if (state.state == ResultState.HasData) {
              return NestedScrollView(
                headerSliverBuilder: (context, isScrolled) {
                  return [
                    SliverAppBar(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      title: Text(state.details.restaurant.name),
                      expandedHeight: 200,
                      pinned: true,
                      flexibleSpace: Stack(
                        children: [
                          Positioned.fill(
                            child: Hero(
                              tag: state.details.restaurant.pictureId,
                              child: Image.network(
                                RestaurantDetailScreen._baseImageUrl +
                                    "small/" +
                                    state.details.restaurant.pictureId,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            color: primaryColor.withOpacity(0.7),
                          ),
                        ],
                      ),
                    ),
                  ];
                },
                body: _buildDetail(state.details.restaurant),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.NoInternet) {
              return NoInternet();
            } else {
              return CenterMessage(message: 'Unknown Error');
            }
          },
        ),
      ),
    );
  }

  Widget _buildDetail(Restaurant resDetails) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 0.0),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          resDetails.name,
                          style: myTextTheme.headline6,
                        ),
                        SizedBox(width: 8.0),
                        Row(
                          children: resDetails.categories.map(
                            (i) {
                              return Text(
                                i.name + ' ',
                                style: myTextTheme.caption,
                              );
                            },
                          ).toList(),
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: purple2,
                              ),
                              SizedBox(
                                width: 4.0,
                              ),
                              Expanded(
                                child: Text(
                                  resDetails.address + ', ' + resDetails.city,
                                  style: myTextTheme.caption,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber),
                              SizedBox(
                                width: 4.0,
                              ),
                              Text(
                                resDetails.rating.toString(),
                                style: myTextTheme.caption,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      resDetails.description,
                      style: myTextTheme.bodyText2,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: Text(
                    'Foods',
                    style: myTextTheme.headline6,
                  ),
                ),
              ],
            ),
          ),
          _buildMenus(resDetails.menus.foods),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 16.0),
                Text(
                  'Drinks',
                  style: myTextTheme.headline6,
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          _buildMenus(resDetails.menus.drinks),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Customer Review',
                        style: myTextTheme.headline6,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      for (var rev in resDetails.customerReviews)
                        ListTile(
                          title: Text(
                            rev.name + ' -- ' + rev.date,
                            style: myTextTheme.headline6,
                          ),
                          subtitle: Text(
                            rev.review,
                            style: myTextTheme.caption,
                          ),
                        ),
                      ElevatedButton(
                        onPressed: () async {
                          await showReviewDialog(
                              context, resDetails.id, resDetails.name);
                        },
                        child: Text(
                          'Add a review',
                          style: myTextTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenus(List<Category> childList) {
    return SliverGrid.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16.0,
      mainAxisSpacing: 16.0,
      children: childList.map((items) {
        return Card(
          shadowColor: purple1,
          child: GridTile(
            child: Image.asset('assets/placeholder.png'),
            footer: GridTileBar(
              title: Text(
                items.name,
                style: myTextTheme.bodyText2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Future<void> showReviewDialog(
      BuildContext context, String resId, String resName) async {
    return await showDialog(
      context: context,
      builder: (context) {
        final TextEditingController _txtReview = TextEditingController();
        final TextEditingController _txtName = TextEditingController();

        return AlertDialog(
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Write your review about ' + resName,
                  style: myTextTheme.bodyText2,
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _txtName,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Name must be filled";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                  ),
                ),
                SizedBox(height: 8.0),
                TextFormField(
                  controller: _txtReview,
                  validator: (value) {
                    return value!.isNotEmpty ? null : "Review must be filled";
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your review",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: myTextTheme.button),
            ),
            TextButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  bool success = await widget.apiService.postCustomerReview(
                      resId, _txtName.text, _txtReview.text);

                  try {
                    if (success) {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Review added!'),
                              actions: [
                                TextButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.pop(context);
                                    });
                                  },
                                )
                              ],
                            );
                          });
                    } else {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text('Failed to add review!'),
                            );
                          });
                    }
                    Navigator.pop(context);
                  } catch (e) {
                    print('Error --> $e');
                  }
                }
              },
              child: Text('Submit', style: myTextTheme.button),
            ),
          ],
        );
      },
    );
  }
}
