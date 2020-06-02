import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key, this.restaurant}) : super(key: key);
  final Records restaurant;

  @override
  _CartScreenState createState() => _CartScreenState(restaurant);
}

class _CartScreenState extends State<CartScreen> {
  String title;
  String category;
  String description;
  String price;
  String discount;
  final Records restaurant;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  double total;
  bool delete = false;

  _CartScreenState(this.restaurant);

  _buildList(){
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    return Expanded(
      child: ListView.separated(
        itemCount: currentUser.cartDataModel.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cartDataModel.cart.length) {
            Order order = currentUser.cartDataModel.cart[index];
            return Container(
              color: Colors.white,
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: _buildCartItem(order),
            );
          }
          return  Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Итого',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                      ),),
                    Text(
                        '${totalPrice.toStringAsFixed(0)} \Р',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey
                        )
                    ),
                  ],
                ),
                SizedBox(height: 80.0)
              ],
            )
          );
        }, separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1.0,
          color: Colors.grey,
        );
      },
      ),
    );
  }

  _buildCartItem(Order order){
    GlobalKey<CounterState> counterKey = new GlobalKey();
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
      Expanded(
      child: Container(
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    !order.isSelected ?
                    Padding(
                      padding: EdgeInsets.only(top: 15,bottom: 15,left: 10),
                      child: Text(
                        '${order.quantity.toStringAsFixed(0)}',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        ),
                      ),
                    ): Counter(key: counterKey,initial_counter: order.quantity,),
                    Padding(
                      padding: EdgeInsets.only(left: 10, top: 15,bottom: 15),
                      child: Image(image: AssetImage('assets/images/cross.png'),),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10 ),
                        child: Text(
                          order.food.name,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    )
                  ]
              ),
            ),
            Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Text(
                      '${order.quantity * order.food.price} \Р',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Color(0xB0B0B0B0)
                      )
                  ),
                )
            ),
          ],
        ),
        onTap: (){
            setState(() {
              if(order.isSelected){
                order.quantity = counterKey.currentState.counter;
              }
              order.isSelected = !order.isSelected;
            });
        },
      )
    ))]));
  }


  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    Order bloc;
    return new Scaffold(
      key: _scaffoldStateKey,
     body: Container(
       color: Colors.white,
       child: Column(
         children: <Widget>[
           Padding(
             padding: EdgeInsets.only(top:50),
             child: Column(
               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Flexible(
                       flex: 0,
                       child: Padding(
                         padding: EdgeInsets.only(left: 5),
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
                     ),
                     Flexible(
                       flex: 0,
                       child: Padding(
                         padding: EdgeInsets.only(left: 0),
                         child:  Text(restaurant.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                       ),
                     ),
                     Flexible(
                       flex: 0,
                       child: Padding(
                           padding: EdgeInsets.only(right: 5),
                           child: Container(
                               height: 30,
                               width: 30,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.all(Radius.circular(5))
                               ),
                               child: GestureDetector(
                                 child: Image(
                                   image: AssetImage('assets/images/delete.png'),
                                 ),
                                 onTap: (){
                                   setState(() {
                                     currentUser.cartDataModel.cart.clear();
                                   });
                                 },
                               )
                           )
                       ),
                     ),
                   ],
                 ),
                 Padding(
                   padding: EdgeInsets.only(top: 10, bottom: 5),
                   child: Container(
                     color: Color(0xF5F5F5F5),
                     height: 10,
                     width: 700,
                   ),
                 ),
                 Container(
                   child: Row(
                     children: <Widget>[
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           Padding(
                             padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                             child:
                             Text("Доставка еды", style: TextStyle(fontWeight: FontWeight.bold),),
                           ),
                           Padding(
                             padding: EdgeInsets.only(left: 15, top: 5, bottom: 5),
                             child:
                             Text("Закажите еще на 1000 Р. для бесплатной\nдоставки"),
                           ),
                         ],
                       ),
                       Padding(
                         padding: EdgeInsets.only(left: 20),
                         child: Text("134 Р", style: TextStyle(color: Colors.grey),),
                       ),
                     ],
                   ),
                 ),
                 Container(
                   color: Color(0xF5F5F5F5),
                   height: 10,
                   width: 600,
                 ),
               ],
             ),
           ),
           _buildList(),
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
                               'Далее',
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
                 onPressed: (){Navigator.push(
                   context,
                   new MaterialPageRoute(
                     builder: (context) => new AddressScreen(restaurant: restaurant),
                   ),
                 );},
               ),
             ),
           ),
         ],
       )
     ),
    );
  }
}

class Counter extends StatefulWidget{
  final int initial_counter;
  Counter({Key key, this.initial_counter}) : super(key: key);

  @override
  CounterState createState() {
    return new CounterState(counter: initial_counter);
  }
}

class CounterState extends State<Counter>{
  int counter = 1;
  CounterState({this.counter});
  // ignore: non_constant_identifier_names
  void _incrementCounter_plus(){
    setState(() {
      counter++;
    });
  }
  // ignore: non_constant_identifier_names
  void _incrementCounter_minus(){
    setState(() {
      counter--;
    });
  }

  Widget build(BuildContext context){
    return  Padding(
      padding: EdgeInsets.only(top: 0, left: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xF5F5F5F5))
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: GestureDetector(
                  onTap: () {
                    _incrementCounter_minus();
                  },child: Text(
                  '-',
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                ),
              ),
              SizedBox(width: 20.0),
              Padding(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  '$counter',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _incrementCounter_plus();
                    });
                  },
                  child: Text(
                    '+',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
            ]
        ),
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}