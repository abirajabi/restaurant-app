import 'package:align_positioned/align_positioned.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:restaurant_app2/common/const.dart';
import 'package:restaurant_app2/common/styles.dart';
import 'package:restaurant_app2/controller/res_detail_controller.dart';
import 'package:restaurant_app2/data/api/api_service.dart';
import 'package:restaurant_app2/data/models/restaurant_detail.dart';
import 'package:restaurant_app2/widgets/center_message.dart';
import 'package:restaurant_app2/widgets/no_internet.dart';
import 'package:sizer/sizer.dart';

class RestaurantDetailScreen extends StatefulWidget {
  static final String routeName = '/detail';
  static final String _baseImageUrl =
      "https://restaurant-api.dicoding.dev/images/";
  final ApiService apiService = ApiService();

  RestaurantDetailScreen();

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String resId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: GetBuilder<ResDetailController>(
        init: ResDetailController(resId: resId, apiService: widget.apiService),
        builder: (controller) {
          if (controller.state == ResultState.Loading) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
                backgroundColor: secondaryColor,
              ),
            );
          } else if (controller.state == ResultState.HasData) {
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    title: Text(controller.detail.restaurant.name),
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: controller.detail.restaurant.pictureId,
                            child: Image.network(
                              RestaurantDetailScreen._baseImageUrl +
                                  "small/" +
                                  controller.detail.restaurant.pictureId,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          color: primaryColor.withOpacity(0.7),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 3.w),
                          child: AlignPositioned(
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {},
                            ),
                            alignment: Alignment.bottomRight,
                            moveByChildHeight: 0.5,
                          ),
                        )
                      ],
                    ),
                  ),
                ];
              },
              body: _buildDetail(controller.detail.restaurant),
            );
          } else if (controller.state == ResultState.NoData) {
            return Center(child: Text(controller.message));
          } else if (controller.state == ResultState.Error) {
            return Center(child: Text(controller.message));
          } else if (controller.state == ResultState.NoInternet) {
            return NoInternet();
          } else {
            return CenterMessage(message: 'Unknown Error');
          }
        },
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
                Get.back();
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
                                    Get.back();
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
                    Get.back();
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
