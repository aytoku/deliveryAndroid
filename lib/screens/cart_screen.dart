import 'package:flutter/cupertino.dart';
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
  Order bloc;

  _buildList(){
    double totalPrice = 0;
    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    return ListView.separated(
      itemCount: currentUser.cart.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index < currentUser.cart.length) {
          Order order = currentUser.cart[index];
          return _buildCartItem(order);

        }
      }, separatorBuilder: (BuildContext context, int index) {
      return Divider(
        height: 1.0,
        color: Colors.grey,
      );
    },
    );
  }

  _buildCartItem(Order order){
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                height: 40,
                child: Expanded(
                    child:  Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left:12.0, right: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    width: 100.0,
                                    child: Container(
                                        padding: EdgeInsets.only(left:4.0, right: 4),
                                        child: new Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 20.0),
                                              Padding(
                                                padding: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  '${order.quantity.toStringAsFixed(0)}',
                                                  style: TextStyle(
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(left: 30, top: 8),
                                                child: Image(image: AssetImage('assets/images/cross.png'),),
                                              )
                                            ]
                                        )
                                    )
                                ),
                                Text(
                                  order.food.name,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Container(
                                  //  margin: EdgeInsets.all(3.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 120, top: 10),
                                          child: Text(
                                              '${order.quantity * order.food.price}',
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xB0B0B0B0)
                                              )
                                          ),
                                        ),
                                      ],
                                    )
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                ),
              )
            ],
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
    Order bloc;

    return  Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Padding(
            padding: EdgeInsets.only(top:40),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child:  FloatingActionButton(
                        backgroundColor: Colors.white,
                        isExtended: true,
                        child: Image(
                          image: AssetImage('assets/images/arr.png'),
                        ),
                        onPressed: () {Navigator.pop(context);},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80),
                      child:  Text(currentUser.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 80),
                      child: DragTargetWidget(bloc),
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
          Padding(
            padding: EdgeInsets.only(top: 100),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 340,
                child: _buildList(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 60),
                      child: Text(
                        '30 – 50 мин',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Text(
                          'Далее',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          )
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Text(
                          '${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.white
                          )
                      ),
                    ),
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
                    builder: (context) => new AddressScreen(),
                  ),
                );},
              ),
            ),
          )
        ],
      ),
    );
  }
}


class DragTargetWidget extends StatefulWidget {
  final Order bloc;

  DragTargetWidget(this.bloc);

  @override
  _DragTargetWidgetState createState() => _DragTargetWidgetState();
}

class _DragTargetWidgetState extends State<DragTargetWidget> {
  @override
  Widget build(BuildContext context) {
    Food currentFoodItem;

    return DragTarget<Food>(
      onAccept: (Food foodItem) {
        currentFoodItem = foodItem;
        // widget.bloc.removeFromList(currentFoodItem);
      },
      onWillAccept: (Food foodItem) {
        return true;
      },


      builder: (BuildContext context, List incoming, List rejected) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Icon(
            CupertinoIcons.delete,
            size: 35,
          ),
        );
      },
    );
  }
}