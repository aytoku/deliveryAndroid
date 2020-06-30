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
import 'package:food_delivery/screens/device_id_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:intl/intl.dart';

import 'auth_screen.dart';

class ProfileScreen extends StatefulWidget {

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen>{

  TextEditingController nameField = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    nameField.text = necessaryDataForAuth.name;
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Align(
              child: Padding(
                padding: EdgeInsets.only(top: 40, bottom: 30, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: GestureDetector(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.only(),
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                                  ),
                                )
                            )
                        ),
                        onTap: (){
                          homeScreenKey = new GlobalKey<HomeScreenState>();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              HomeScreen()), (Route<dynamic> route) => false);
                        },
                      ),
                    ),
                    Flexible(
                      flex: 10,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Text("Ваши данные", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                        ),
                      ),
                    )
                  ],
                ),
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
                      color: Color(0xFF8A8A8A)
                  ),
                ),
              )
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 30,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 0),
                    child: TextField(
                      style: TextStyle(
                        color: Color(0xFF515151),
                        fontSize: 17
                      ),
                      controller: nameField,
                      textAlign: TextAlign.start,
                      keyboardType: TextInputType.text,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                      ),
                      onChanged: (value){
                        necessaryDataForAuth.name = value;
                        NecessaryDataForAuth.saveData();
                      },
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
                      color: Color(0xFF8A8A8A)
                  ),
                ),
              )
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: GestureDetector(
                    child: Text(
                      necessaryDataForAuth.phone_number,
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xFF515151)
                      ),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new AuthScreen(),
                        ),
                      );
                    },
                  )
                )
            ),
            Divider(height: 1.0, color: Colors.grey),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 330),
                child: GestureDetector(
                  child: Text('Выход', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF424242)),),
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