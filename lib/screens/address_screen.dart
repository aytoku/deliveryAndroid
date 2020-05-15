import 'package:flutter/material.dart';
import 'file:///C:/Users/GEOR/AndroidStudioProjects/newDesign/lib/buttons/button.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
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

class _AddressScreenState extends State<AddressScreen> {
  String address  = 'Адрес доставки';
  String office;
  String floor;
  String comment;
  String delivery;

  bool _color;
  @override
  void initState() {
    super.initState();
    _color = true;
  }

  String title = 'VISA ****8744';

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 50,
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                              color: (_color ? Colors.white : Colors.redAccent),),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
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
                  Flexible(
                    flex: 1,
                    child: SizedBox(
                      height: 50,
                      child: GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                              color: (_color ? Colors.white : Colors.redAccent),),
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, right: 15, top: 15),
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
                      child: _buildTextFormField("Кв./офис"),
                    ),Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: _buildTextFormField("Подъезд"),
                    ),Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 20),
                      child: _buildTextFormField("Комментарий к заказу"),
                    ),
//                    Padding(
//                      padding: EdgeInsets.only(left: 15, bottom: 20),
//                      child: _buildTextFormField("Доставка"),
//                    ),
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
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20,bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Image(image: AssetImage('assets/images/card.png'),),
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 170),
                            child: Image(image: AssetImage('assets/images/arrow_right.png'),),
                          )
                        ],
                      ),
                    ),
                    onTap: _onPress,
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 10),
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Text(
                            '30 – 50 мин',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),),
                        ),
                        Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 30,
                              ),
                              child: Text(
                                  'Оплатить',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )
                              ),
                            )
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                              '${totalPrice.toStringAsFixed(0)}',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white
                              )
                          ),
                        )
                      ],
                    ),
                    color: Colors.redAccent,
                    splashColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.only(left: 10, top: 20, right: 20, bottom: 20),
                    onPressed: (){
                      CreateOrder createOrder = new CreateOrder(
                          address: address,
                          office: office,
                          floor: floor,
                          comment: comment,
                          order: currentUser.cart[0]
                      );
                      createOrder.sendData();
//                      Navigator.push(
//                      context,
//                      new MaterialPageRoute(
//                        builder: (context) => new HomeScreen(),
//                      ),
//                    );
                      },
                  ),
                ),
              ),
            ],
          )
        )
    );
  }

  void _onPress(){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  )
              ),
            ),
          );
        }
    );
  }

  Column _buildBottomNavigationMenu(){
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("Наличными", style: TextStyle(color: Colors.black),),
          onTap: ()=>_selectItem("Наличными",),
        ),
        ListTile(
          title: Text("VISA ****8744", style: TextStyle(color: Colors.black),),
          onTap: ()=>_selectItem("VISA ****8744",),
        ),
        ListTile(
          title: Text("Другой картой", style: TextStyle(color: Colors.black),),
          onTap: ()=>_selectItem("Другой картой",),
        ),
      ],
    );
  }

  void _selectItem(String name){
    Navigator.pop(context);
    setState(() {
      title = name;
    });
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
      validator: (String value) {
        if (value.isEmpty && hint == "Адрес доставки") {
          return "Заполните поле";
        }
        if (value.isEmpty && hint == "Кв./офис  Домофон") {
          return "Заполните поле";
        }

        if (value.isEmpty && hint == "Подъезд  Этаж") {
          return "Заполните поле";
        }

//        if (value.isEmpty && hint == "Доставка") {
//          return "Заполните поле";
//        }

        if (value.isEmpty && hint == "Комментарий к заказу") {
          return "Заполните поле";
        }
      },
      onChanged: (String value) {
        if (hint == "Адрес доставки") {
          address = value;
        }
        if (hint == "Кв./офис  Домофон") {
          office = value;
        }
        if (hint == "Подъезд  Этаж") {
          floor = value;
        }
        if (hint == "Комментарий к заказу") {
          comment = value;
        }
//        if (hint == "Доставка") {
//          delivery = value;
//        }
      },
    );
  }
}