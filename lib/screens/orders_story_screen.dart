import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/orders_story_data.dart';
import 'package:food_delivery/PostData/restaurant_data_pass.dart';
import 'package:food_delivery/PostData/restaurant_items_data_pass.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/orders_details.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:food_delivery/widgets/recent_orders.dart';
import 'package:intl/intl.dart';

import 'cart_screen.dart';
import 'home_screen.dart';

class OrdersStoryScreen extends StatefulWidget {
  OrdersStoryScreen({Key key}) : super(key: key);

  @override
  OrdersStoryScreenState createState() => OrdersStoryScreenState();
}

class OrdersStoryScreenState extends State<OrdersStoryScreen> {
  int page = 1;
  int limit = 12;
  bool isLoading = true;
  List<OrdersStoryModelItem> records_items = new List<OrdersStoryModelItem>();

  noConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget column(OrdersStoryModelItem ordersStoryModelItem) {
    var format = new DateFormat('HH:mm, dd-MM-yy');
    var date = new DateTime.fromMicrosecondsSinceEpoch(
        ordersStoryModelItem.created_at_unix * 1000);
    var time = '';
    time = format.format(date);
    return Column(
      children: <Widget>[
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, left: 15),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(ordersStoryModelItem.routes[0].value,
                      style: TextStyle(fontSize: 14, color: Color(0xFF000000))),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                child: Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 5, left: 15, bottom: 15),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${ordersStoryModelItem.price} \Р',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ),
            )
          ],
        ),
        Divider(height: 1.0, color: Colors.grey),
      ],
    );
  }

  _buildOrdersStoryItems() {
    List<Widget> restaurantList = [];
    int i = 0;
    GlobalKey<CartItemsQuantityState> cartItemsQuantityKey = new GlobalKey();
    records_items.forEach((OrdersStoryModelItem ordersStoryModelItem) {
      var format = new DateFormat('HH:mm, dd-MM-yy');
      var date = new DateTime.fromMicrosecondsSinceEpoch(
          ordersStoryModelItem.created_at_unix * 1000);
      var time = '';
      time = format.format(date);
      restaurantList.add(
        InkWell(
            child: column(ordersStoryModelItem),
            onTap: () async {
              if (await Internet.checkConnection()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) {
                    return OrdersDetailsScreen(
                        ordersStoryModelItem: ordersStoryModelItem);
                  }),
                );
              } else {
                noConnection(context);
              }
            }),
      );
      i++;
    });

    return Column(children: restaurantList);
  }

  void _onPressedButton(OrdersStoryModelItem food,
      GlobalKey<CartItemsQuantityState> cartItemsQuantityKey) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
        )),
        context: context,
        builder: (context) {
          return Container(
              height: 450,
              child: Container(
                child: _buildBottomNavigationMenu(food, cartItemsQuantityKey),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                    )),
              ));
        });
  }

  void _deleteButton() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(0),
          topRight: const Radius.circular(0),
        )),
        context: context,
        builder: (context) {
          return Container(
              height: 140,
              child: Container(
                child: _buildDeleteBottomNavigationMenu(),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                    )),
              ));
        });
  }

  Column _buildDeleteBottomNavigationMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Align(
          child: Padding(
            padding: EdgeInsets.only(right: 0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      'Вы действительно хотите удалить\nданную поездку?',
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(top: 30, left: 15),
                          child: GestureDetector(
                            child: Text(
                              'Закрыть',
                              style: TextStyle(fontSize: 17),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )),
                      Padding(
                          padding: EdgeInsets.only(top: 30, right: 15),
                          child: GestureDetector(
                            child: Text(
                              'Удалить заказ',
                              style: TextStyle(fontSize: 17),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildBottomNavigationMenu(OrdersStoryModelItem restaurantDataItems,
      GlobalKey<CartItemsQuantityState> cartItemsQuantityKey) {
    var format = new DateFormat('HH:mm');
    var date = new DateTime.fromMicrosecondsSinceEpoch(
        restaurantDataItems.created_at_unix * 1000);
    var time = '';
    time = format.format(date);
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 15),
            child: Text(
              time,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 15),
              child: Text(
                (restaurantDataItems.store != null)
                    ? restaurantDataItems.routes[0].unrestricted_value
                    : 'Пусто',
                style: TextStyle(
                  fontSize: 17.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 15),
              child: Text(
                (restaurantDataItems.store != null)
                    ? restaurantDataItems.routes[1].unrestricted_value
                    : 'Пусто',
                style: TextStyle(
                  fontSize: 17.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            )),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 15),
              child: Text(
                'Заказ',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            )),
        Flexible(
          child: Padding(
              padding: EdgeInsets.only(top: 10, left: 15),
              child: ListView(
                children: List.generate(
                    (restaurantDataItems.products != null)
                        ? restaurantDataItems.products.length
                        : 0, (index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                              '${restaurantDataItems.products[index].number}'),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                          ),
                          child: Image(
                            image: AssetImage('assets/images/cross.png'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(restaurantDataItems.products[index].name),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                              '${restaurantDataItems.products[index].price} \Р'),
                        )
                      ],
                    ),
                  );
                }),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          child: FlatButton(
            child: Center(
              child: Text(
                'Удалить заказ',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0x42424242),
                ),
              ),
            ),
            color: Color(0xF5F5F5F5),
            splashColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
            onPressed: _deleteButton,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: FutureBuilder<OrdersStoryModel>(
            future: loadOrdersStoryModel(),
            initialData: null,
            builder: (BuildContext context,
                AsyncSnapshot<OrdersStoryModel> snapshot) {
              print(snapshot.connectionState);
              if (snapshot.hasData) {
                records_items = snapshot.data.ordersStoryModelItems;
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                              child: Padding(
                                  padding: EdgeInsets.only(left: 0, top: 0),
                                  child: Container(
                                      height: 40,
                                      width: 60,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            top: 12, bottom: 12, right: 10),
                                        child: SvgPicture.asset(
                                            'assets/svg_images/arrow_left.svg'),
                                      ))),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "История заказов",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF3F3F3F)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(height: 1.0, color: Colors.grey),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (!isLoading &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                setState(() {
                                  isLoading = true;
                                });
                              }
                            },
                            child: _buildOrdersStoryItems()),
                      ],
                    )
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
