import 'package:flutter/material.dart';
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

class AddressScreen extends StatefulWidget {

  AddressScreen({Key key}) : super(key: key);

  @override
  _AddressScreenState createState() => _AddressScreenState();
}

_showModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child:  Align(
          child: Padding(
            padding: EdgeInsets.only(right: 0),
            child: Column(
              children: <Widget>[
                new FlatButton(
                  child: Row(
                    children: <Widget>[
                      Image(image: AssetImage('assets/dollar.png'),),
                      Padding(
                        padding: EdgeInsets.only(right: 0, left: 15),
                        child: Text("Наличными", style: TextStyle(color: Colors.black),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 160),
                        child:
                        Image(image: AssetImage('assets/check_box.png'),),
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
                new FlatButton(
                  child: Row(
                    children: <Widget>[
                      Image(image: AssetImage('assets/play.png'),),
                      Padding(
                        padding: EdgeInsets.only(right: 0, left: 15),
                        child: Text("Apple Pay", style: TextStyle(color: Colors.black),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 180),
                        child:
                        Image(image: AssetImage('assets/check_box.png'),),
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
                new FlatButton(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 90),
                        child: Text("Другой картой", style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                  onPressed: () {
                  },
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _AddressScreenState extends State<AddressScreen> {
  String address  = 'Адрес доставки';
  String office;
  String floor;
  String comment;

  bool _color;
  @override
  void initState() {
    super.initState();
    _color = true;
  }

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  final maxLines = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    return Scaffold(
        key: _scaffoldStateKey,
        resizeToAvoidBottomPadding: false,
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(
                            context
                        ),
                        child:Padding(
                          padding: EdgeInsets.only(right: 0),
                          child: Image(
                            width: 30,
                            height: 30,
                            image: AssetImage('assets/images/arr.png'),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 95),
                      child:  Text("Оформление заказа", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 50,
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                              color: (_color ? Colors.white : Colors.redAccent),),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 12),
                              child: Text('Доставка',
                                style: TextStyle(color: _color ? Color(0x99999999) : Colors.white, fontSize: 15),),
                            ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            _color = !_color;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: SizedBox(
                      height: 50,
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                              color: (_color ? Colors.white : Colors.redAccent),),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 12),
                              child: Text('Заберу сам',
                                style: TextStyle(color: _color ? Color(0x99999999) : Colors.white, fontSize: 15),),
                            ),
                          ),
                        ),
                        onTap: (){
                          setState(() {
                            _color = !_color;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 1, left: 20),
                child: Row(
                  children: <Widget>[
                    Text("Адрес доставки", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Form(
                key: _foodItemFormKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: _buildTextFormField(address),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: _buildTextFormField("Кв./офис  Домофон"),
                    ),Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: _buildTextFormField("Подъезд  Этаж"),
                    ),Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: _buildTextFormField("Комментарий к заказу"),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                    child: Row(
                      children: <Widget>[
                        Text("Способ оплаты", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Color(0xB0B0B0B0)),),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Theme(
                    data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
                    child: ModalTrigger(),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Padding(
                          padding: EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
                          child: ScopedModelDescendant(
                            builder: (BuildContext context, Widget child, MainModel model){
                              return GestureDetector(
                                onTap: () {
                                  onSubmit(model.addFood);
                                  if (model.isLoading) {
                                    showLoadingIndicator();
                                  }
                                },
                                child: Button(btnText: '${totalPrice.toStringAsFixed(2)}',),
                              );
                            },
                          )
                      ),
                    )
                )
              )
            ],
          )
        )
    );
  }
  void onSubmit(Function addFood) async{
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      final Food food = Food(
        address: address,
        office: office,
        floor: floor,
        comment: comment,
      );
      bool value = await addFood(food);
      if(value){
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
            content: Text("Заказ прошел успешно")
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }else if(!value){
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
            content: Text("Произоше сбой")
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }
    }
  }

  Future<void> showLoadingIndicator() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            content: Row(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(width: 10.0,),
                Text("Идет оплата"),
              ],
            ),
          );
        }
    );
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
//      validator: (String value) {
//        if (value.isEmpty && hint == "Адрес доставки") {
//          return "Заполните поле";
//        }
//        if (value.isEmpty && hint == "Кв./офис  Домофон") {
//          return "Заполните поле";
//        }
//
//        if (value.isEmpty && hint == "Подъезд  Этаж") {
//          return "Заполните поле";
//        }
//
//        if (value.isEmpty && hint == "Комментарий к заказу") {
//          return "Заполните поле";
//        }
//      },
//      onChanged: (String value) {
//        if (hint == "Адрес доставки") {
//          address = value;
//        }
//        if (hint == "Кв./офис  Домофон") {
//          office = value;
//        }
//        if (hint == "Подъезд  Этаж") {
//          floor = value;
//        }
//        if (hint == "Комментарий к заказу") {
//          comment = value;
//        }
//      },
    );
  }
}