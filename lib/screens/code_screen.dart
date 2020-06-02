import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/PostData/auth_code_data_pass.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
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

class CodeScreen extends StatefulWidget {

  CodeScreen({Key key}) : super(key: key);

  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {

  TextField code1;
  TextField code2;
  TextField code3;
  TextField code4;
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder<AuthData>(
        future: loadAuthData(necessaryDataForAuth.device_id, currentUser.phone),
        builder: (BuildContext context, AsyncSnapshot<AuthData> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Column(
              children: <Widget>[
                GestureDetector(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 50),
                        child: SvgPicture.asset('assets/svg_images/arrow_left.svg')
                      )
                  ),
                  onTap: () => Navigator.pop(
                      context
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: Text('Введите код из смс',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30, left: 30),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: code1 = TextField(
                              focusNode: new FocusNode(),
                              controller: new TextEditingController(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: new InputDecoration(
                                counterText: '',
                              ),
                              onChanged: (String value){
                                if(value != ''){
                                  code2.focusNode.requestFocus();
                                }
                              }
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: code2 = TextField(
                              focusNode: new FocusNode(),
                              controller: new TextEditingController(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: new InputDecoration(
                                counterText: '',
                              ),
                              onChanged: (String value){
                                if(value != ''){
                                  code3.focusNode.requestFocus();
                                }
                              }
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: code3 = TextField(
                              focusNode: new FocusNode(),
                              controller: new TextEditingController(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 28),
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: new InputDecoration(
                                counterText: '',
                              ),
                              onChanged: (String value){
                                if(value != ''){
                                  code4.focusNode.requestFocus();
                                }
                              }
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          child: code4 = TextField(
                            focusNode: new FocusNode(),
                            controller: new TextEditingController(),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: new InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(error,style: TextStyle(color: Colors.red, fontSize: 12),),
                ),
                Container(
                  height: 400,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10, top: 298),
                          child: new TimerCountDown(codeScreenState: this),
                        ),
                        Padding(
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
                            onPressed: ()async {
                              String temp = '';
                              temp = code1.controller.text +
                                  code2.controller.text +
                                  code3.controller.text +
                                  code4.controller.text;
                              authCodeData = await loadAuthCodeData(necessaryDataForAuth.device_id, int.parse(temp));
                              if(authCodeData != null){
                                necessaryDataForAuth = await NecessaryDataForAuth.saveData(currentUser.phone, authCodeData.refresh_token);
                                Navigator.pushReplacement(
                                  context,
                                  new MaterialPageRoute(
                                    builder: (context) => new HomeScreen(),
                                  ),
                                );
                              }else{
                                setState(() {
                                  error = 'Вы ввели неверный смс код';
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ),
                )
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(
              ),
            );
          }
        },
      )
    );
  }
}

class TimerCountDown extends StatefulWidget {
  TimerCountDown({Key key, this.codeScreenState,}) : super(key: key);
  final _CodeScreenState codeScreenState;

  @override
  TimerCountDownState createState() {
    return new TimerCountDownState(codeScreenState: codeScreenState);
  }
}

class TimerCountDownState extends State<TimerCountDown> {
  TimerCountDownState({this.codeScreenState});
  final _CodeScreenState codeScreenState;
  Timer _timer;
  int _start = 60;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState((){
          if (_start < 1) {
            timer.cancel();
            _timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_start == 60){
      startTimer();
    }
    return  _start != 0 ?  Center(
      child: Text(
          'Получить новый код можно через $_start c',
          style: TextStyle(
            color: Color(0x97979797),
            fontSize: 13.0,
            letterSpacing: 1.2,
          )
      ),
    ): GestureDetector(
      child: Text('Отпарвить код повторно', style: TextStyle(),),
      onTap: (){
        codeScreenState.setState(() {

        });
      },
    );
  }
}