import 'package:flutter/material.dart';
import 'package:food_delivery/PostData/auth_code_data_pass.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
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

import 'food_bottom_sheet_screen.dart';

class CodeScreen extends StatefulWidget {

  CodeScreen({Key key}) : super(key: key);

  @override
  _CodeScreenState createState() => _CodeScreenState();
}

class _CodeScreenState extends State<CodeScreen> {

  var code = ['0','0','0','0'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder<AuthData>(
        future: loadAuthData(device_id, currentUser.phone),
        builder: (BuildContext context, AsyncSnapshot<AuthData> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return Column(
              children: <Widget>[
                GestureDetector(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 50),
                        child: Image(image: AssetImage('assets/images/arrow_left.png'), height: 20, width: 20,),
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
                Row(
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: new InputDecoration(
                              counterText: '',
                            ),
                          onChanged: (String value) async {
                            code[0] = value;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: new InputDecoration(
                              counterText: '',
                            ),
                          onChanged: (String value) async {
                            code[1] = value;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: new InputDecoration(
                              counterText: '',
                            ),
                          onChanged: (String value) async {
                            code[2] = value;
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 28),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            decoration: new InputDecoration(
                              counterText: '',
                            ),
                          onChanged: (String value) async {
                            code[3] = value;
                            print(code);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 430,
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
                        onPressed: ()async {
                          String temp = '';
                          code.forEach((element) {
                            temp += element;
                          });
                          print(temp);
                          authCodeData = await loadAuthCodeData(device_id, int.parse(temp));
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new HomeScreen(),
                            ),
                          );
                        },
                      ),
                    ),
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