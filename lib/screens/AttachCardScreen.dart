import 'package:flutter/material.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
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

class AttachCardScreen extends StatefulWidget {

  AttachCardScreen({Key key}) : super(key: key);

  @override
  AttachCardScreenState createState() => AttachCardScreenState();
}

class AttachCardScreenState extends State<AttachCardScreen> {
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50, left: 15),
              child: Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image(image: AssetImage('assets/images/arrow_left.png'),),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(left: 120),
                      child: Text('Новая карта', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 10),
              child: Text(
                'Номер карты'
              ),
            ),
            const Divider(
              color: Color(0xEDEDEDED),
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
            ),
            Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                          'Срок действия'
                      ),
                    ),
                    const Divider(
                      color: Color(0xEDEDEDED),
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 0,
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                          'CVV'
                      ),
                    ),
                    const Divider(
                      color: Colors.red,
                      height: 20,
                      thickness: 5,
                      indent: 20,
                      endIndent: 0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 10),
                      child: Text(
                          'Трехзначный код на\nобороте карты'
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(error,style: TextStyle(color: Colors.red, fontSize: 12),),
            ),
            Container(
              height: 400,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 0, right: 0, top: 10),
                  child: FlatButton(
                    child: Text(
                        'Привязать карту',
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
                    padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
                    onPressed: () async {
                      if(validateMobile(currentUser.phone)== null){
                        if(currentUser.phone[0] != '+'){
                          currentUser.phone = '+' + currentUser.phone;
                        }
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new CodeScreen(),
                          ),
                        );
                      }else{
                        setState(() {
                          error = 'Указан неверный номер';
                        });
                      }
                    },
                  ),
                ),
              ),
            )
          ],
        )
    );
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+]?7)[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Укажите норер';
    }
    else if (!regExp.hasMatch(value)) {
      return 'Указан неверный номер';
    }
    return null;
  }
}