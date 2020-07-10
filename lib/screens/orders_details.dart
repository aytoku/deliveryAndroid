import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/Internet/check_internet.dart';
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

class OrdersDetailsScreen extends StatefulWidget {

  final OrdersStoryModelItem ordersStoryModelItem;

  OrdersDetailsScreen({Key key, this.ordersStoryModelItem}) : super(key: key);

  @override
  OrdersDetailsScreenState createState() => OrdersDetailsScreenState(ordersStoryModelItem);
}

class OrdersDetailsScreenState extends State<OrdersDetailsScreen>{

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
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
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

  bool status1 = false;
  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    var format = new DateFormat('HH:mm');
    var date = new DateTime.fromMicrosecondsSinceEpoch(ordersStoryModelItem.created_at_unix * 1000);
    var time = '';
    time = format.format(date);
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:30, bottom: 0),
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
                              padding: EdgeInsets.only(top: 12, bottom: 12, right: 10),
                              child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                            )
                        )
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                Flexible(
                  flex: 6,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text("Детали заказа", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF3F3F3F)),),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 15, right: 0 ),
                  child: Text((ordersStoryModelItem.store != null) ? ordersStoryModelItem.routes[0].value : 'Пусто',
                    style: TextStyle(fontSize: 14, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 35),
                  child: Text(time, style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 170, top: 15),
                      child: Text('Статус заказа: ',
                        style: TextStyle(fontSize: 14, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15, left: 5, right: 5),
                          child: Text(ordersStoryModelItem.state_title, style: TextStyle(fontSize: 14, color: Color(0xFFFE534F), fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 105, top: 35),
                  child: Text('Заберу с собой', style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 70),
                  child: Text('Адрес заведения', style: TextStyle(fontSize: 14, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 90, bottom: 10),
                  child: Text((ordersStoryModelItem.store != null) ? ordersStoryModelItem.routes[0].street + ordersStoryModelItem.routes[0].house : 'Пусто',
                    style: TextStyle(fontSize: 12, color: Color(0xFFB0B0B0)),),
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
                children: List.generate((ordersStoryModelItem.products != null) ? ordersStoryModelItem.products.length : 0, (index){
                  return Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child:
                                    Text('${ordersStoryModelItem.products[index].number}',
                                      style: TextStyle(
                                        color: Color(0xFF000000),
                                        fontSize: 14
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15),
                                    child: SvgPicture.asset('assets/svg_images/cross.svg'),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(ordersStoryModelItem.products[index].name,
                                      style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 14
                                    ),),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15),
                                child:
                                Text('${ordersStoryModelItem.products[index].price} \Р',
                                  style: TextStyle(color: Color(0xFFB0B0D0), fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Divider(height: 1.0, color: Colors.grey),
                        )
                      ],
                    )
                  );
                }),
              ),
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.only(left: 15),
//                child: Text(
//                  'Итого',
//                  style: TextStyle(
//                      fontSize: 20.0,
//                      fontWeight: FontWeight.w600
//                  ),),
//              ),
//              Padding(
//                padding: EdgeInsets.only(right: 15),
//                child: Text(
//                    '${totalPrice.toStringAsFixed(0)} \Р',
//                    style: TextStyle(
//                        fontSize: 20.0,
//                        fontWeight: FontWeight.w600,
//                        color: Colors.grey
//                    )
//                ),
//              )
//            ],
//          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: EdgeInsets.only(left: 80, bottom: 20, right: 0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        child: Container(
                            height: 50,
                            width: 200,
                            decoration: BoxDecoration(
                              color: Color(0xFFFE534F),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Center(
                              child: Text('Повторить заказ', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
                            )
                        ),
                        onTap: () async {
                          if(await Internet.checkConnection()){
                            Records restaurant = ordersStoryModelItem.store;
                            currentUser.cartDataModel.cart.clear();
                            ordersStoryModelItem.products.forEach((FoodRecordsStory element) {
                              FoodRecords foodItem = FoodRecords.fromFoodRecordsStory(element);
                              Order order = new Order(
                                  restaurant: restaurant,
                                  food:  foodItem,
                                  date: DateTime.now().toString(),
                                  quantity: element.number,
                                  isSelected: false
                              );
                              currentUser.cartDataModel.cart.add(order);
                            });
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) {
                                    return new CartScreen(restaurant:restaurant);
                                  }
                              ),
                            );
                          }else{
                            noConnection(context);
                          }
                        },
                      ),
                    )
                ),
              )
            ],
          )
//          Padding(
//            padding: EdgeInsets.only(top: 20),
//            child: Column(
//              children: <Widget>[
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Column(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(left: 15),
//                          child: Text('Sandwich club', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(left: 15, top: 5),
//                          child: Text('20:00, 20.09.20', style: TextStyle(fontSize: 12, color: Color(0xB0B0B0B0)),),
//                        )
//                      ],
//                    ),
//                    Column(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(right: 15),
//                          child: Text('Статус заказа: Выдан', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(left: 50, top: 5),
//                          child: Text('Заберу с собой', style: TextStyle(fontSize: 12, color: Color(0xB0B0B0B0)),),
//                        )
//                      ],
//                    )
//                  ],
//                ),
//                Padding(
//                  padding: EdgeInsets.only(right: 220, top: 10),
//                  child: Text('Адрес заведения', style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(right: 210, top: 5, bottom: 10),
//                  child: Text('Хаджи Мамсурова, 42', style: TextStyle(fontSize: 12, color: Color(0xB0B0B0B0)),),
//                ),
//                Container(
//                  height: 30,
//                  color: Color(0xF3F3F3F3),
//                ),
//                Container(
//                  child: Align(
//                    alignment: Alignment.bottomCenter,
//                    child: Padding(
//                      padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 10),
//                      child: FlatButton(
//                        child: Text(
//                            'Далее',
//                            style: TextStyle(
//                                fontSize: 14.0,
//                                fontWeight: FontWeight.w600,
//                                color: Colors.white
//                            )
//                        ),
//                        color: Colors.grey,
//                        splashColor: Colors.grey,
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(50),
//                        ),
//                        padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
//                      ),
//                    ),
//                  ),
//                )
//              ],
//            )
//          )
        ],
      )
    );
  }
}