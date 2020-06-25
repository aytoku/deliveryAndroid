import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/PostData/auth_code_data_pass.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/firebase_notification_handler.dart';
import 'package:food_delivery/sideBar/side_bar.dart';
import 'package:food_delivery/test/api_test.dart';
import 'address_screen.dart';
import 'file:///C:/Users/GEOR/AndroidStudioProjects/newDesign/lib/buttons/button.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_list.dart';
import 'package:food_delivery/models/global_state.dart';
import 'package:food_delivery/models/modal_trigger.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/order_redister.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:food_delivery/screens/add_card_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';


import 'food_bottom_sheet_screen.dart';

class NameScreen extends StatefulWidget {

  NameScreen({Key key}) : super(key: key);

  @override
  NameScreenState createState() => NameScreenState();
}

class NameScreenState extends State<NameScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, top: 50),
                      child: Container(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                          )
                      )
                  )
              ),
              onTap: () => Navigator.pop(
                  context
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 0, bottom: 15),
                        child: Text('Как вас зовут?',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Color(0xB5B5B5B5))),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 30, left: 30, bottom: 100),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xF5F5F5F5),
                                      borderRadius: BorderRadius.circular(7.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: Color(0xF5F5F5F5)
                                      )
                                  ),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 28),
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                    onChanged: (String value)async {
                                      necessaryDataForAuth.name = value;
                                      print(necessaryDataForAuth.name);
                                    },
                                  ),
                                )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: Container(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 20, left: 0, right: 0, top: 0),
                            child: FlatButton(
                              child: Text(
                                  'Далее',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )
                              ),
                              color: Colors.grey,
                              splashColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
                              onPressed: ()async {
                                await NecessaryDataForAuth.saveData();
                                await new FirebaseNotifications().setUpFirebase();
                                print(necessaryDataForAuth.name);
                                homeScreenKey = new GlobalKey<HomeScreenState>();
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    HomeScreen()), (Route<dynamic> route) => false);
                              },
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}