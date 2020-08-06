import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/OrderCancel.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/address_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

class OrdersDetailsScreen extends StatefulWidget {
  final OrdersStoryModelItem ordersStoryModelItem;

  OrdersDetailsScreen({Key key, this.ordersStoryModelItem}) : super(key: key);

  @override
  OrdersDetailsScreenState createState() =>
      OrdersDetailsScreenState(ordersStoryModelItem);
}

class OrdersDetailsScreenState extends State<OrdersDetailsScreen> {
  final OrdersStoryModelItem ordersStoryModelItem;

  OrdersDetailsScreenState(this.ordersStoryModelItem);

  GlobalKey<CartItemsQuantityState> cartItemsQuantityKey = new GlobalKey();

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

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
                height: 150,
                width: 320,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      child: Text(
                        'Отмена заказа',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)),
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  showNoCancelAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(true);
        });
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
                height: 100,
                width: 320,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20, right: 15),
                      child: Text(
                        'Вы не можете отменить заказ',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)),
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }

  bool status1 = false;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach(
        (Order order) => totalPrice += order.quantity * order.food.price);
    var format = new DateFormat('HH:mm');
    var date = new DateTime.fromMicrosecondsSinceEpoch(
        ordersStoryModelItem.created_at_unix * 1000);
    var time = '';
    time = format.format(date);
    var state_array = [
      'waiting_for_confirmation',
      'cooking',
      'offer_offered',
      'smart_distribution',
      'finding_driver',
      'offer_rejected',
      'order_start',
      'on_place',
      'on_the_way',
      'order_payment'
    ];
    var not_cancel_state = [
      'on_the_way',
      'order_payment'
    ];
    // TODO: implement build
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10),
          child: Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: InkWell(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                          height: 40,
                          width: 60,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 12, bottom: 12, right: 10),
                            child: SvgPicture.asset(
                                'assets/svg_images/arrow_left.svg'),
                          ))),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Flexible(
                flex: 6,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 40),
                    child: Text(
                      "Детали заказа",
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
        Divider(height: 1.0, color: Color(0xFFF5F5F5)),
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 15, right: 0),
                child: Text(
                  (ordersStoryModelItem.store != null)
                      ? ordersStoryModelItem.store.name
                      : 'Пусто',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3F3F3F),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 35),
                child: Text(
                  time,
                  style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(left: 170, top: 15, right: 15),
                child: RichText(
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  text: TextSpan(
                      text: 'Статус заказа: ',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF3F3F3F),
                          fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: ordersStoryModelItem.state_title + '\n',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFFFE534F),
                              fontWeight: FontWeight.bold),
                        ),
//                          TextSpan(
//                              text: 'Заберу с собой',
//                              style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0))
//                          )
                      ]),
                ),
              ),
            ),
//              Align(
//                alignment: Alignment.centerRight,
//                child: Container(
//                  child: Row(
//                    children: <Widget>[
//                      Flexible(
//                        child: Container(
//                          child: Padding(
//                            padding: EdgeInsets.only(left: 170, top: 15),
//                            child: Text('Статус заказа: ' + ordersStoryModelItem.state_title,
//                              style: TextStyle(fontSize: 14, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
//                              textAlign: TextAlign.start,
//                              maxLines: 2,
//                            ),
//                          ),
//                        ),
//                      )
////                      Flexible(
////                        child: Container(
////                          child: Padding(
////                            padding: EdgeInsets.only(top: 15, left: 5, right: 5),
////                            child: Text(ordersStoryModelItem.state_title, style: TextStyle(fontSize: 14, color: Color(0xFFFE534F), fontWeight: FontWeight.bold),
////                              //overflow: TextOverflow.ellipsis,
////                              maxLines: 2,
////                              textAlign: TextAlign.start,
////                            ),
////                          ),
////                        ),
////                      )
//                    ],
//                  ),
//                )
//              ),
//              Align(
//                alignment: Alignment.centerRight,
//                child: Padding(
//                  padding: EdgeInsets.only(right: 105, top: 35),
//                  child: Text('Заберу с собой', style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),),
//                ),
//              ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 70),
                child: Text(
                  'Адрес заведения',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3F3F3F),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 90, bottom: 10),
                child: Text(
                  (ordersStoryModelItem.store != null)
                      ? ordersStoryModelItem.routes[0].street +
                          ordersStoryModelItem.routes[0].house
                      : 'Пусто',
                  style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 30,
          color: Color(0xF3F3F3F3),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: List.generate(
                (ordersStoryModelItem.products != null)
                    ? ordersStoryModelItem.products.length
                    : 0, (index) {
              return Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                '${ordersStoryModelItem.products[index].number}',
                                style: TextStyle(
                                    color: Color(0xFF000000), fontSize: 14),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15, right: 15),
                              child: SvgPicture.asset(
                                  'assets/svg_images/cross.svg'),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Text(
                                  ordersStoryModelItem.products[index].name,
                                  style: TextStyle(
                                      color: Color(0xFF000000), fontSize: 14),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Text(
                                '${ordersStoryModelItem.products[index].price} \Р',
                                style: TextStyle(
                                    color: Color(0xFFB0B0D0), fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Divider(height: 1.0, color: Color(0xFFF5F5F5)),
                      )
                    ],
                  ));
            }),
          ),
        ),
        Stack(
          children: <Widget>[
//              Padding(
//                  padding: EdgeInsets.only(left: 20, bottom: 20),
//                  child: GestureDetector(
//                    child: Container(
//                        height: 50,
//                        width: 100,
//                        decoration: BoxDecoration(
//                          color: Color(0xF3F3F3F3),
//                          borderRadius: BorderRadius.circular(50.0),
//                        ),
//                        child: Center(
//                          child: Text('Чек', style: TextStyle(color: Color(0x69696969), fontSize: 15),),
//                        )
//                    ),
//                  )
//              ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(left: 0, bottom: 20, right: 0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: (!state_array.contains(ordersStoryModelItem.state)) ? GestureDetector(
                      child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFFE534F),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Center(
                            child: Text(
                              'Повторить заказ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      onTap: () async {
                        if (await Internet.checkConnection()) {
                          Records restaurant = ordersStoryModelItem.store;
                          currentUser.cartDataModel.cart.clear();
                          ordersStoryModelItem.products
                              .forEach((FoodRecordsStory element) {
                            FoodRecords foodItem =
                                FoodRecords.fromFoodRecordsStory(element);
                            Order order = new Order(
                                restaurant: restaurant,
                                food: foodItem,
                                date: DateTime.now().toString(),
                                quantity: element.number,
                                isSelected: false);
                            currentUser.cartDataModel.cart.add(order);
                          });
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) {
                              return new CartScreen(restaurant: restaurant);
                            }),
                          );
                        } else {
                          noConnection(context);
                        }
                      },
                    ) : GestureDetector(
                      child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFFE534F),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Center(
                            child: Text(
                              'Отменить',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                      onTap: () async {
                        if (await Internet.checkConnection()) {
                          if(not_cancel_state.contains(ordersStoryModelItem.state)){
                            showNoCancelAlertDialog(context);
                            return;
                          }
                          showAlertDialog(context);
                          await loadOrderCancel(ordersStoryModelItem.uuid);
                          homeScreenKey = new GlobalKey();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);
                        } else {
                          noConnection(context);
                        }
                      },
                    ),
                  )),
            )
          ],
        )
      ],
    ));
  }
}
