import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/config/config.dart';
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

import 'auth_screen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 30, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(),
                            child: SvgPicture.asset('assets/svg_images/arrow_left.svg')
                        )
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 130),
                      child: Text("Ваши данные", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: Text(
                  'Ваше имя',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0x8A8A8A8A)
                  ),
                ),
              )
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Text(
                    necessaryDataForAuth.name,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black
                    ),
                  ),
                )
            ),
            Divider(height: 1.0, color: Colors.grey),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 20, bottom: 15),
                child: Text(
                  'Номер телефона',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color(0x8A8A8A8A)
                  ),
                ),
              )
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Text(
                    necessaryDataForAuth.phone_number,
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black
                    ),
                  ),
                )
            ),
            Divider(height: 1.0, color: Colors.grey),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 340),
                child: GestureDetector(
                  child: Text('Выход', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                  onTap: (){
                    NecessaryDataForAuth.clear().then((value){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new AuthScreen(),
                        ),
                      );
                    });
                  },
                ),
              )
            )
          ],
        )
    );
  }
}