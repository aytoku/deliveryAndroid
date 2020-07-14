import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/auth_code_data_pass.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/firebase_notification_handler.dart';
import 'package:food_delivery/sideBar/side_bar.dart';
import 'package:food_delivery/test/api_test.dart';
import 'address_screen.dart';
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
  GlobalKey<ButtonState> buttonStateKey = new GlobalKey<ButtonState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 15, top: 40),
                      child: Container(
                          height: 40,
                          width: 60,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: 12, bottom: 12, right: 30),
                            child: SvgPicture.asset(
                                'assets/svg_images/arrow_left.svg'),
                          )))),
              onTap: () => Navigator.pop(context),
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
                        child: Text('Как вас зовут?',
                            style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: Color(0xB5B5B5B5))),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 30, left: 30, bottom: 100),
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
                                          color: Color(0xF5F5F5F5))),
                                  child: TextField(
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    keyboardType: TextInputType.text,
                                    decoration: new InputDecoration(
                                      hintText: 'Ваше имя',
                                      contentPadding: EdgeInsets.only(left: 15),
                                      hintStyle: TextStyle(
                                          color: Color(0xFFB5B5B5),
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                      border: InputBorder.none,
                                      counterText: '',
                                    ),
                                    onChanged: (String value) async {
                                      if (await Internet.checkConnection()) {
                                        necessaryDataForAuth.name = value;
                                        if (value.length > 0 &&
                                            buttonStateKey.currentState.color !=
                                                Color(0xFFFE534F)) {
                                          buttonStateKey.currentState
                                              .setState(() {
                                            buttonStateKey.currentState.color =
                                                Color(0xFFFE534F);
                                          });
                                        } else if (value.length == 0 &&
                                            buttonStateKey.currentState.color !=
                                                Color(0xFFF3F3F3)) {
                                          buttonStateKey.currentState
                                              .setState(() {
                                            buttonStateKey.currentState.color =
                                                Color(0xFFF3F3F3);
                                          });
                                        }
                                      } else {
                                        noConnection(context);
                                      }
                                    },
                                  ),
                                )),
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
                            padding: EdgeInsets.only(
                                bottom: 20, left: 0, right: 0, top: 0),
                            child: Button(
                              key: buttonStateKey,
                              color: Color(0xFFF3F3F3),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            )
          ],
        ));
  }
}

class Button extends StatefulWidget {
  Color color;

  Button({Key key, this.color}) : super(key: key);

  @override
  ButtonState createState() {
    return new ButtonState(color);
  }
}

class ButtonState extends State<Button> {
  String error = '';
  Color color;

  ButtonState(this.color);

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    if(){
//
//    }
    return FlatButton(
      child: Text('Далее',
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white)),
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
      onPressed: () async {
        if (await Internet.checkConnection()) {
          currentUser.isLoggedIn = true;
          await NecessaryDataForAuth.saveData();
          await new FirebaseNotifications().setUpFirebase();
          print(necessaryDataForAuth.name);
          homeScreenKey = new GlobalKey<HomeScreenState>();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false);
        } else {
          noConnection(context);
        }
      },
    );
  }
}
