import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/CardModel.dart';
import 'package:food_delivery/screens/code_screen.dart';
import 'package:food_delivery/screens/payments_methods_screen.dart';
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
import 'package:flutter_masked_text/flutter_masked_text.dart';

import 'food_bottom_sheet_screen.dart';

class AttachCardScreen extends StatefulWidget {
  final CardModel cardModel;
  AttachCardScreen({Key key, this.cardModel}) : super(key: key);

  @override
  AttachCardScreenState createState() => AttachCardScreenState(cardModel: cardModel);
}

class AttachCardScreenState extends State<AttachCardScreen> {
  String error = '';
  var controller = new MaskedTextController(mask: '00/00');
  TextEditingController numberField = new TextEditingController();
  TextEditingController expirationField = new TextEditingController();
  TextEditingController cvvField = new TextEditingController();
  final CardModel cardModel;
  AttachCardScreenState({this.cardModel});
  @override
  Widget build(BuildContext context) {
    numberField.text = cardModel.number;
    controller.text = cardModel.expiration;
    cvvField.text = cardModel.cvv;
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
                    child: GestureDetector(
                      child: Container(
                          width: 20,
                          height: 20,
                          child: Center(
                            child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                          )
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    )
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 35, left: 15),
                child: Text(
                    'Номер карты'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 0, left: 15, right: 15),
              child: TextField(
                maxLength: 12,
                keyboardType: TextInputType.number,
                controller: numberField,
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.only(left: 0),
                  hintText: '',
                  counterText: '',
                ),
              ),
            ),
            Expanded(
              child:  Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 15),
                            child: Text(
                                'Срок действия'
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                          child: TextField(
                            controller: controller,
                            maxLength: 5,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0),
                              hintText: '',
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 15, left: 15),
                            child: Text(
                                'CVV'
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 0, left: 15, right: 15),
                          child: TextField(
                            maxLength: 4,
                            controller: cvvField,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0),
                              hintText: '',
                              counterText: '',
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            'Трехзначный код на\nобороте карты'
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 350,
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
                      cardModel.number = numberField.text;
                      cardModel.expiration = controller.text;
                      cardModel.cvv = cvvField.text;
                      await CardModel.saveData();
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new PaymentsMethodsScreen(),
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