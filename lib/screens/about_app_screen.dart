import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
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

class AboutAppScreen extends StatefulWidget {

  @override
  AboutAppScreenState createState() => AboutAppScreenState();
}

class AboutAppScreenState extends State<AboutAppScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 30, left: 15),
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(),
                            child: Container(
                              width: 20,
                              height: 20,
                              child: Center(
                                child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                              )
                            )
                        )
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 100),
                      child: Text("О приложении", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child:  SvgPicture.asset('assets/svg_images/faem_icon.svg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Center(
                child: Text(
                  'Версия 4.95 от 25 авг. 2019 г.\nсборка 34234',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0x97979797),
                      fontSize: 15
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              color: Color(0xF3F3F3F3),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 15),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Лицензионное соглашение'),
                        GestureDetector(
                          child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Divider(height: 1.0, color: Colors.grey),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 15),
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Политика конфиденцальности'),
                        GestureDetector(
                          child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                        )
                      ],
                    ),
                  )
              ),
            ),
            Divider(height: 1.0, color: Colors.grey),
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Center(
                child: Text(
                  'Таким образом новая модель организационной\nдеятельности представляет собой интересный\nэксперимент проверки. \n@ 2011-2019 ООО «Faem.Taxi»',
                  style: TextStyle(
                      color: Color(0x97979797),
                      fontSize: 15
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}