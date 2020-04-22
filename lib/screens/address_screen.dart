import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_list.dart';
import 'package:food_delivery/models/global_state.dart';
import 'package:food_delivery/models/modal_trigger.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/add_card_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';

import 'food_bottom_sheet_screen.dart';

class AddressScreen extends StatefulWidget {

  final AddressScreen restaurant;

  AddressScreen({this.restaurant});

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

_showModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child:  Align(
          child: Padding(
            padding: EdgeInsets.only(right: 0),
            child: Column(
              children: <Widget>[
                new FlatButton(
                  child: Row(
                    children: <Widget>[
                      Image(image: AssetImage('assets/dollar.png'),),
                      Padding(
                        padding: EdgeInsets.only(right: 0, left: 15),
                        child: Text("Наличными", style: TextStyle(color: Colors.black),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 160),
                        child:
                        Image(image: AssetImage('assets/check_box.png'),),
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
                new FlatButton(
                  child: Row(
                    children: <Widget>[
                      Image(image: AssetImage('assets/play.png'),),
                      Padding(
                        padding: EdgeInsets.only(right: 0, left: 15),
                        child: Text("Apple Pay", style: TextStyle(color: Colors.black),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 180),
                        child:
                        Image(image: AssetImage('assets/check_box.png'),),
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
                new FlatButton(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 90),
                        child: Text("Другой картой", style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _AddressScreenState extends State<AddressScreen> {
  final maxLines = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    return Container(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(
                          context
                      ),
                      child:Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Image(
                          width: 30,
                          height: 30,
                          image: AssetImage('assets/images/arr.png'),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 80),
                    child:  Text("Оформление заказа", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 1, left: 20),
              child: Row(
                children: <Widget>[
                  Text("Адрес доставки", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Адрес доставки", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xB0B0B0B0)),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Container(
                          height: maxLines * 40.0,
                          width: maxLines * 300.0,
                          child: TextField(
                            maxLines: maxLines,
                            decoration: InputDecoration(
                              hintText: "",
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text("Кв./офис", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Color(0xB0B0B0B0)),),
                        Padding(
                          padding: EdgeInsets.only(left: 150),
                          child: Text("Домофон", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Color(0xB0B0B0B0)),),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Container(
                            height: maxLines * 40.0,
                            width: maxLines * 300.0,
                            child: TextField(
                              maxLines: maxLines,
                              decoration: InputDecoration(
                                hintText: "",
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Подъезд", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Color(0xB0B0B0B0)),),
                      Padding(
                        padding: EdgeInsets.only(left: 150),
                        child: Text("Этаж", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Color(0xB0B0B0B0)),),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Container(
                          height: maxLines * 40.0,
                          width: maxLines * 300.0,
                          child: TextField(
                            maxLines: maxLines,
                            decoration: InputDecoration(
                              hintText: "",
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Комментарий к заказу", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold,color: Color(0xB0B0B0B0)),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 40),
                        child: Container(
                          height: maxLines * 40.0,
                          width: maxLines * 300.0,
                          child: TextField(
                            maxLines: maxLines,
                            decoration: InputDecoration(
                              hintText: "",
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                  child: Row(
                    children: <Widget>[
                      Text("Способ оплаты", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Color(0xB0B0B0B0)),),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Theme(
                  data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                  child: ModalTrigger(),
                ),
              ],
            ),

            Padding(
              padding: EdgeInsets.only(top: 40, right: 20, left: 20),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 60),
                      child: Text(
                        '30 – 50 мин',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Text(
                          'Далее',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                          '${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          )
                      ),
                    ),
                  ],
                ),
                color: Colors.redAccent,
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
                onPressed: (){Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new HomeScreen(),
                  ),
                );},
              ),
            )
          ],
        )
      ),
    );
  }
}