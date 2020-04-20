import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:food_delivery/screens/home_screen.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  double total;

  _buildCartItem(Order order){
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 400.0,
      child: Column(
        children: <Widget>[
          Expanded(
              child:  Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(bottom:12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                           'Оформление заказа',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          SizedBox(height: 20.0),
//          Container(
//            padding: EdgeInsets.only(bottom:10.0),
//            child: Text(
//                'Адрес доставки',
//                style: TextStyle(
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.bold
//                )
//            ),
//          ),
          SizedBox(height: 10.0),
//          Container(
//            padding: EdgeInsets.only(bottom:10.0),
//            child: Row(
//              children: <Widget>[
//                Text(
//                    'Адрес доставки',
//                    style: TextStyle(
//                        fontSize: 11.0,
//                        color: Color(0xB0B0B0B0),
//                        fontWeight: FontWeight.bold
//                    )
//                ),
//
//              ],
//            ),
//          ),
//          SizedBox(height: 20.0),
//          Container(
//            padding: EdgeInsets.only(bottom:10.0),
//            child: Row(
//              children: <Widget>[
//                Text(
//                    'Хаджи мамсурова',
//                    style: TextStyle(
//                        fontSize: 13.0,
//                        color: Color(0xB0B0B0B0),
//                        fontWeight: FontWeight.bold
//                    )
//                ),
//
//              ],
//            ),
//          ),
//          SizedBox(height: 20.0),
//          Container(
//            padding: EdgeInsets.only(bottom:10.0),
//            child: Row(
//              children: <Widget>[
//                Text(
//                    'Кв./офис',
//                    style: TextStyle(
//                        fontSize: 13.0,
//                        color: Color(0xB0B0B0B0),
//                        fontWeight: FontWeight.bold
//                    )
//                ),
//                Text(
//                    'Домофон',
//                    style: TextStyle(
//                        fontSize: 13.0,
//                        color: Color(0xB0B0B0B0),
//                        fontWeight: FontWeight.bold
//                    )
//                ),
//              ],
//            ),
//          ),
//          SizedBox(height: 20.0),
//          Container(
//            padding: EdgeInsets.only(bottom:10.0),
//            child: Row(
//              children: <Widget>[
//                Text(
//                    'Подъезд',
//                    style: TextStyle(
//                        fontSize: 13.0,
//                        color: Color(0xB0B0B0B0),
//                        fontWeight: FontWeight.bold
//                    )
//                ),
//                Text(
//                    'Этаж',
//                    style: TextStyle(
//                        fontSize: 13.0,
//                        color: Color(0xB0B0B0B0),
//                        fontWeight: FontWeight.bold
//                    )
//                ),
//              ],
//            ),
//          ),
//          SizedBox(height: 20.0),
//          Container(
//            padding: EdgeInsets.only(bottom:10.0),
//            child: Row(
//              children: <Widget>[
//                Text(
//                    'Комментарий к заказу',
//                    style: TextStyle(
//                        fontSize: 11.0,
//                        color: Color(0xB0B0B0B0),
//                        fontWeight: FontWeight.bold
//                    )
//                ),
//              ],
//            ),
//          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {

    double totalPrice = 0;
    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    Food menuItem;

    return new Scaffold(

      body: ListView.separated(
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            Order order = currentUser.cart[index];
            return _buildCartItem(order);
          }
          return Padding(
            padding: EdgeInsets.only(top:20.0, left: 30),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: FlatButton(
                        child: Text("Оплатить", style: TextStyle(color: Colors.white, fontSize: 15),),
                        color: Colors.red,
                        splashColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.only(left: 120, top: 14.5, right: 120, bottom: 14.5),
                        onPressed: (){Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new HomeScreen(),
                          ),
                        );},
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1.0,
          color: Colors.grey,
        );
      },
      ),
    );
  }
}