import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:flutter_counter/flutter_counter.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/address_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key, this.restaurant}) : super(key: key);
  final Restaurant restaurant;
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  double total;

  _buildCartItem(Order order){
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 170.0,
      child: Row(
        children: <Widget>[
          Expanded(
              child:  Row(
                children: <Widget>[
//                  Container(
//                    width: 150.0,
//                    decoration: BoxDecoration(
//                        image: DecorationImage(
//                            image:AssetImage(order.food.imageUrl),
//                            fit: BoxFit.cover
//                        ),
//                        borderRadius: BorderRadius.circular(15.0)
//                    ),
//                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                              width: 100.0,
//                              decoration: BoxDecoration(
//                                  borderRadius: BorderRadius.circular(10.0),
//                                  border: Border.all(
//                                      width: 0.8,
//                                      color: Colors.black54
//                                  )
//                              ),
                              child: Container(
                                  padding: new EdgeInsets.all(4.0),
                                  child: new Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
//                                        GestureDetector(
//                                          onTap: () {
//                                            if (order.quantity > 1) {
//                                              setState(() {
//                                                order.quantity--;
//                                              });
//                                            }
//                                          },child: Text(
//                                          '-',
//                                          style: TextStyle(
//                                            fontSize: 24.0,
//                                            fontWeight: FontWeight.w600,
//                                            color: Theme.of(context).primaryColor,
//                                          ),
//                                        ),
//                                        ),
                                        SizedBox(width: 20.0),
                                        Text(
                                          '${order.quantity.toStringAsFixed(0)}',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
//                                        GestureDetector(
//                                          onTap: () {
//                                            setState(() {
//                                              if (order.quantity < 10) {
//                                                order.quantity++;
//                                              }
//                                            });
//                                          },
//                                          child: Text(
//                                          '+',
//                                          style: TextStyle(
//                                            fontSize: 24.0,
//                                            fontWeight: FontWeight.w600,
//                                            color: Theme.of(context).primaryColor,
//                                          ),
//                                        ),
//                                        ),
                                      ]
                                  )
                              )
                            /* Counter(
                            buttonSize: 25.0,
                            color: Theme.of(context).primaryColor,
                            initialValue: order.quantity,
                            minValue: 1,
                            maxValue: 100,
                            step: 1,
                            decimalPlaces: 0,
                            onChanged: (value) { // get the latest value from here
                              setState(() {
                                //  order.quantity = value;
                              });
                            },
                          ), */
                          ),
                          Text(
                            order.food.name,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
//                          Text(
//                            order.restaurant.name,
//                            style: TextStyle(
//                                fontSize: 13.0,
//                                fontWeight: FontWeight.w600
//                            ),
//                            overflow: TextOverflow.ellipsis,
//                          ),
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
                '${order.quantity * order.food.price}',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600
                )
            ),
          )
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

//      appBar: AppBar(
//        title: Text(widget.restaurant.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
//        leading: FloatingActionButton(
//          backgroundColor: Colors.white,
//          isExtended: true,
//          child: Image(
//            image: AssetImage('assets/images/arr.png'),
//          ),
//          onPressed: () {Navigator.pop(context);},
//        ),
//      ),

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
                      'Итого',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600
                      ),),
                    Text(
                        '${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                        )
                    ),
                  ],
                ),
                SizedBox(height: 80.0),
                Padding(
                  padding: EdgeInsets.only(top: 220),
                  child: FlatButton(
                    child: Text("Далее", style: TextStyle(color: Colors.white, fontSize: 15),),
                    color: Colors.red,
                    splashColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.only(left: 120, top: 14.5, right: 120, bottom: 14.5),
                    onPressed: (){Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new AddressScreen(),
                      ),
                    );},
                  ),
                )
              ],
            ),
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
}