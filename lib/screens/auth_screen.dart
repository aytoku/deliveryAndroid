import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/screens/code_screen.dart';
import 'package:food_delivery/screens/device_id_screen.dart';
import 'package:url_launcher/url_launcher.dart';
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
  var controller = new MaskedTextController(mask: '+7 000 000-00-00');
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
        body: Stack(
          children: <Widget>[
            GestureDetector(
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 0, top: 30),
                      child: Container(
                          height: 40,
                          width: 60,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 12, bottom: 12, right: 10),
                            child: SvgPicture.asset(
                                'assets/svg_images/arrow_left.svg'),
                          )))),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 80),
                  child: Text(
                    'Ваш номер телефона',
                    style: TextStyle(
                        fontSize: 19, fontWeight: FontWeight.bold),
                  ),
                ),),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 150),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 0),
                          child: Text(
                            'Россия +7',
                            style:
                            TextStyle(fontSize: 17, color: Color(0xFF979797)),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: TextField(
                            controller: controller,
                            style: TextStyle(fontSize: 28),
                            textAlign: TextAlign.center,
                            maxLength: 16,
                            keyboardType: TextInputType.phone,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0),
                              hintText: '+79188888888',
                              counterText: '',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFFD6F6D)),
                              ),
                            ),
                            onChanged: (String value) {
                              currentUser.phone = value;
                              if (value.length > 0 &&
                                  buttonStateKey.currentState.color !=
                                      Color(0xFFFE534F)) {
                                buttonStateKey.currentState.setState(() {
                                  buttonStateKey.currentState.color =
                                      Color(0xFFFE534F);
                                });
                              } else if (value.length == 0 &&
                                  buttonStateKey.currentState.color !=
                                      Color(0xF3F3F3F3)) {
                                buttonStateKey.currentState.setState(() {
                                  buttonStateKey.currentState.color =
                                      Color(0xF3F3F3F3);
                                });
                              }
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 80, top: 10),
                  child: Text.rich(
                    TextSpan(
                        text:
                        'Нажимая кнопку “Далее”, вы принимете условия\n',
                        style: TextStyle(
                            color: Color(0x97979797), fontSize: 13),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Пользовательского соглашения',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await Internet.checkConnection()) {
                                    if (await canLaunch(
                                        "https://faem.ru/legal/agreement")) {
                                      await launch(
                                          "https://faem.ru/legal/agreement");
                                    }
                                  } else {
                                    noConnection(context);
                                  }
                                }),
                          TextSpan(
                            text: ' и ',
                          ),
                          TextSpan(
                              text: 'Политики\nконфиденцальности',
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await Internet.checkConnection()) {
                                    if (await canLaunch(
                                        "https://faem.ru/privacy")) {
                                      await launch(
                                          "https://faem.ru/privacy");
                                    }
                                  } else {
                                    noConnection(context);
                                  }
                                }),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Button(key: buttonStateKey)),
            ),
          ],
        ));
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+]?7)[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Укажите норер';
    } else if (!regExp.hasMatch(value)) {
      return 'Указан неверный номер';
    }
    return null;
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
  Color color = Color(0xFFF3F3F3);

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
      splashColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      padding: EdgeInsets.only(left: 120, top: 20, right: 120, bottom: 20),
      onPressed: () async {
        if (await Internet.checkConnection()) {
          currentUser.phone = currentUser.phone.replaceAll('-', '');
          currentUser.phone = currentUser.phone.replaceAll(' ', '');
          print(currentUser.phone);
          if (validateMobile(currentUser.phone) == null) {
            if (currentUser.phone[0] != '+') {
              currentUser.phone = '+' + currentUser.phone;
            }
            if (currentUser.phone != necessaryDataForAuth.phone_number) {
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CodeScreen(),
                ),
              );
            } else {
              if (!(authCodeData != null &&
                  authCodeData.refresh_token != null &&
                  await CreateOrder.sendRefreshToken())) {
                await NecessaryDataForAuth.clear();
              }
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new DeviceIdScreen(),
                ),
              );
            }
          } else {
            setState(() {
              error = 'Указан неверный номер';
            });
          }
        } else {
          noConnection(context);
        }
      },
    );
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+]?7)[0-9]{10}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return 'Укажите норер';
    } else if (!regExp.hasMatch(value)) {
      return 'Указан неверный номер';
    }
    return null;
  }
}
