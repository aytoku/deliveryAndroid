import 'package:flutter/material.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/screens/code_screen.dart';
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

import 'food_bottom_sheet_screen.dart';

class AuthScreen extends StatefulWidget {

  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 80),
              child: Text('Ваш номер телефона', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: TextField(
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                contentPadding: EdgeInsets.only(left: 0),
                hintText: '+79188888888',
              ),
              onChanged: (String value)async {
                currentUser.phone = value;
              },
            ),
          ),
          Container(
            height: 450,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 10),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.only(left: 150, top: 20, right: 150, bottom: 20),
                  onPressed: (){
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new CodeScreen(),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}