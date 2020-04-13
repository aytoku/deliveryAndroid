import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:flutter_counter/flutter_counter.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  double total;

  _buildCartItem(Order order){
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 170.0,
      child: Column(
        children: <Widget>[
          Expanded(
              child:  Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: 100.0,
                              child: Container(
                                  padding: new EdgeInsets.all(4.0),
                                  child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: 20.0),
                                        Text(
                                          '${order.quantity.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ]
                                  )
                              )
                          ),
                          Text(
                           'Оформление заказа',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          Container(
            //  margin: EdgeInsets.all(3.0),
            child: Text(
                'Адрес доставки',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                )
            ),
          ),
          Container(
            //  margin: EdgeInsets.all(3.0),
            child: Text(
                'Адрес доставки',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                )
            ),
          ),
          Container(
            //  margin: EdgeInsets.all(3.0),
            child: Text(
                'Хаджи мамсурова',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                )
            ),
          ),
          Container(
            //  margin: EdgeInsets.all(3.0),
            child: Row(
              children: <Widget>[
                Text('Кв./офис'),
                Text('Домофон')
              ],
            ),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    double totalPrice = 0;
    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    Food menuItem;

    return new Scaffold(
      appBar: AppBar(
        title: Text('Корзина (${currentUser.cart.length})'),
        centerTitle: true,
      ),

      body: ListView.separated(
        itemCount: currentUser.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cart.length) {
            Order order = currentUser.cart[index];
            return _buildCartItem(order);

          }
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Время ожидания',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                      ),),
                    Text(
                        '25 мин.',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600
                        )
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Общая сумма',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                      ),),
                    Text(
                        '${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700]
                        )
                    ),
                  ],
                ),
                SizedBox(height: 80.0)
              ],
            ),
          );


        }, separatorBuilder: (BuildContext context, int index) {
        return Divider(
          height: 1.0,
          color: Colors.green,
        );
      },
      ),
//      bottomSheet: Container(
//        height: 80.0,
//        width: MediaQuery.of(context).size.width,
//        decoration: BoxDecoration(
//          color: Theme.of(context).primaryColor,
//          boxShadow: [
//            BoxShadow(
//              color: Colors.black26,
//              offset: Offset(0, -1),
//              blurRadius: 6.0
//            )
//          ]
//        ),
//        child: Center(
//          child: FlatButton(
//             child: Text(
//                'CHECKOUT',
//                style: TextStyle(
//                  color: Colors.white,
//                  fontSize: 22.0,
//                  fontWeight: FontWeight.bold,
//                  letterSpacing: 2.0
//                )
//          ),
//          onPressed: () {
//            print("Merci bcp");
//          },
//          ),
//        ),
//      ),
    );
  }
}