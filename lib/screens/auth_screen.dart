import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/screens/code_screen.dart';
import 'package:food_delivery/screens/device_id_screen.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 90),
                child: Text('Ваш номер телефона', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
              ),
            )
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(bottom: 100),
              child: TextField(
                controller: controller,
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
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(error,style: TextStyle(color: Colors.red, fontSize: 12),),
            ),
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    'Нажимая кнопку “Далее”, вы принимете условия\nПользовательского соглашения и Политики\nконфиденцальности',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0x97979797),
                        fontSize: 13
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20, left: 0, right: 0, top: 10),
                      child: (controller.text.length > 0) ? FlatButton(
                        child: Text(
                            'Далее',
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white
                            )
                        ),
                        color: Colors.red,
                        splashColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
                        onPressed: () async {
                          if(validateMobile(currentUser.phone)== null){
                            if(currentUser.phone[0] != '+'){
                              currentUser.phone = '+' + currentUser.phone;
                            }
                            if(currentUser.phone != necessaryDataForAuth.phone_number){
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new CodeScreen(),
                                ),
                              );
                            }else{
                              Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new DeviceIdScreen(),
                                ),
                              );
                            }
                          }else{
                            setState(() {
                              error = 'Указан неверный номер';
                            });
                          }
                        },
                      ): FlatButton(
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
                            if(currentUser.phone != necessaryDataForAuth.phone_number){
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new CodeScreen(),
                                ),
                              );
                            }else{
                              Navigator.push(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new DeviceIdScreen(),
                                ),
                              );
                            }
                          }else{
                            setState(() {
                              error = 'Указан неверный номер';
                            });
                          }
                        },
                      ),
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

class Button extends StatefulWidget{
  Color color;
  Button({Key key, this.color}) : super(key: key);

  @override
  ButtonState createState() {
    return new ButtonState(color);
  }
}

class ButtonState extends State<Button>{
  String error = '';
  Color color;
  ButtonState(this.color);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FlatButton(
      child: Text(
          'Далее',
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white
          )
      ),
      color: Colors.red,
      splashColor: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
      onPressed: () async {
        if(validateMobile(currentUser.phone)== null){
          if(currentUser.phone[0] != '+'){
            currentUser.phone = '+' + currentUser.phone;
          }
          if(currentUser.phone != necessaryDataForAuth.phone_number){
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new CodeScreen(),
              ),
            );
          }else{
            Navigator.push(
              context,
              new MaterialPageRoute(
                builder: (context) => new DeviceIdScreen(),
              ),
            );
          }
        }else{
          setState(() {
            error = 'Указан неверный номер';
          });
        }
      },
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