import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
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

class AuthScreen extends StatefulWidget {

  AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  String error = '';
  var controller = new MaskedTextController(mask: '+70000000000');
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
              maxLength: 13,
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(

                contentPadding: EdgeInsets.only(left: 0),
                hintText: '+79188888888',
                counterText: '',
              ),
              onChanged: (String value)async {
                currentUser.phone = value;
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(error,style: TextStyle(color: Colors.red, fontSize: 12),),
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 300),
                child: Text(
                    'Нажимая кнопку “Далее”, вы принимете условия\nПользовательского соглашения и Политики\nконфиденцальности',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0x97979797),
                    fontSize: 13
                  ),
                ),
              ),
              Container(
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
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
                      onPressed: () async {
                        if(validateMobile(currentUser.phone)== null){
                          if(currentUser.phone[0] != '+'){
                            currentUser.phone = '+' + currentUser.phone;
                          }
                          Navigator.push(
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