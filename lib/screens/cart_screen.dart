import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'address_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String title;
  String category;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  double total;

  _buildList(){

    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    return Expanded(
      child: ListView.separated(
        itemCount: currentUser.cartDataModel.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cartDataModel.cart.length) {
            Order order = currentUser.cartDataModel.cart[index];
            return _buildCartItem(order);
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
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
      Expanded(
      child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15,bottom: 15,left: 10),
                    child: Text(
                      '${order.quantity.toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 15,bottom: 15),
                    child: Image(image: AssetImage('assets/images/cross.png'),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10 ),
                    child: Text(
                      order.food.name,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold
                      ),
                      overflow: TextOverflow.ellipsis,
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
                  '${order.quantity * order.food.price}',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Color(0xB0B0B0B0)
                  )
              ),
            )
          ),
        ],
      ),
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
             padding: EdgeInsets.only(top:40),
             child: Column(
               children: <Widget>[
                 Row(
                   children: <Widget>[
                     Padding(
                       padding: EdgeInsets.only(left: 15),
                       child: GestureDetector(
                          onTap: () => Navigator.pop(
                            context
                          ),
                         child:Padding(
                           padding: EdgeInsets.only(right: 20),
                           child: Image(
                             width: 30,
                             height: 30,
                             image: AssetImage('assets/images/arr.png'),
                           ),
                         ),
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.only(left: 80),
                       child:  Text('Корзина', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
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
                     builder: (context) => new AddressScreen(),
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

  void onSubmit(Function addFood) async{
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      final Food food = Food(
        name: title,
        price: double.parse(price),
      );
      bool value = await addFood(food);
      if(value){
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
            content: Text("Food item successfully added.")
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }else if(!value){
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
            content: Text("Failed to add food item")
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }
    }
  }

//  Future<void> showLoadingIndicator() {
//    return showDialog(
//        context: context,
//        barrierDismissible: false,
//        builder: (BuildContext context){
//          return AlertDialog(
//            content: Row(
//              children: <Widget>[
//                CircularProgressIndicator(),
//                SizedBox(width: 10.0,),
//                Text("Adding food item..."),
//              ],
//            ),
//          );
//        }
//    );
//  }
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