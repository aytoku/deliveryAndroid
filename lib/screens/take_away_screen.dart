import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/models/CreateModelTakeAway.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/screens/auto_complete.dart';
import 'package:food_delivery/sideBar/side_bar.dart';
import 'AttachCardScreen.dart';
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

class TakeAwayScreen extends StatefulWidget {

  TakeAwayScreen({Key key,  this.restaurant}) : super(key: key);
  final Records restaurant;

  @override
  _TakeAwayScreenState createState() => _TakeAwayScreenState(restaurant);
}

class _TakeAwayScreenState extends State<TakeAwayScreen> {
  String address  = 'Адрес доставки';
  String office;
  String floor;
  String comment;
  String delivery;
  final Records restaurant;

  bool _color;

  _TakeAwayScreenState(this.restaurant);
  @override
  void initState() {
    super.initState();
    _color = true;
  }

  String title = 'Visa8744';
  String image = 'assets/images/card.png';

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  GlobalKey<AutoCompleteDemoState> destinationPointsKey = new GlobalKey();
  final maxLines = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
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
                            child: Container(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                                )
                            )
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
                        height: 40,
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                                color: Colors.white,),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                                child: Text('Доставка',
                                  style: TextStyle(color: Color(0x99999999), fontSize: 15),),
                              ),
                            ),
                          ),
                          onTap: (){
                            setState(() {
                              {
                                Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => new AddressScreen(restaurant: restaurant),
                                ),
                              );}
                            });
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 40,
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                                color:  Colors.redAccent,),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                                child: Text('Заберу сам',
                                  style: TextStyle(color: Colors.white, fontSize: 15),),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _foodItemFormKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 20, left: 15),
                              child: Text('Адрес заведения', style: TextStyle(color: Color(0xB0B0B0B0),fontWeight: FontWeight.bold, fontSize: 11),)
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 10, top: 0, left: 15),
                              child: Text(restaurant.name, style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 21),)
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 20,left: 15),
                              child: Text(restaurant.destination_points[0].unrestricted_value,style: TextStyle(color: Colors.black, fontSize: 15),)
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 20, left: 15,),
                              child: Text('Комментарий к заказу', style: TextStyle(color: Color(0xB0B0B0B0),fontWeight: FontWeight.bold, fontSize: 11),)
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 20),
                          child: _buildTextFormField(""),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 5, top: 20, left: 15,),
                              child: Text('Время ожидания', style: TextStyle(color: Color(0xB0B0B0B0),fontWeight: FontWeight.bold, fontSize: 11),)
                          ),
                        ],
                      ),
                      Container(
                        height: 20,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 20),
                          child: _buildTextFormField(""),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Color(0xFAFAFAFA),
                  height: 60,
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
                        padding: EdgeInsets.only(left: 20,bottom: 35),
                        child: Row(
                          children: <Widget>[
                            Image.asset(image),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 200),
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
                    padding: EdgeInsets.only(bottom: 10, left: 20, right: 20, top: 9),
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
                        CreateOrderTakeAway createOrderTakeAway = new CreateOrderTakeAway(
                            comment: comment,
                            cartDataModel: currentUser.cartDataModel,
                            restaurant: restaurant
                        );
                        createOrderTakeAway.sendData();
                        Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new HomeScreen(),
                        ),
                      );},
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
            height: 240,
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
          leading: Image(image: AssetImage('assets/images/visa.png'),),
          title: Text("Visa8744", style: TextStyle(color: Colors.black),),
          trailing: Image(image: AssetImage('assets/images/circle.png'),),
          onTap: ()=>_selectItem("Visa8744",'assets/images/visa.png'),
        ),
        ListTile(
          leading: Image(image: AssetImage('assets/images/visa.png'),),
          title: Text("Visa8744", style: TextStyle(color: Colors.black),),
          trailing: Image(image: AssetImage('assets/images/circle.png'),),
          onTap: ()=>_selectItem("Visa8744",'assets/images/visa.png'),
        ),
        ListTile(
          leading: Image(image: AssetImage('assets/images/Apple_Pay.png'),),
          title: Text("Apple Pay", style: TextStyle(color: Colors.black),),
          trailing: Image(image: AssetImage('assets/images/circle.png'),),
          onTap: ()=>_selectItem("Apple Pay",'assets/images/Apple_Pay.png'),
        ),
        ListTile(
          title: Text("Привязать Карту", style: TextStyle(color: Colors.black),),
          trailing: Image(image: AssetImage('assets/images/arrow_right.png'),),
//          onTap: (){
//            Navigator.push(context, new MaterialPageRoute(builder:
//            (context)=> new AttachCardScreen()));
//          }
        ),
      ],
    );
  }

  void _selectItem(String name, String image_name){
    Navigator.pop(context);
    setState(() {
      title = name;
      image = image_name;
    });
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

        if (value.isEmpty && hint == "Доставка") {
          return "Заполните поле";
        }

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
        if (hint == "Доставка") {
          delivery = value;
        }
      },
    );
  }
}