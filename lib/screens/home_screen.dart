import 'dart:math';

import 'package:flutter/material.dart';
import 'package:food_delivery/PostData/restaurant_items_data_pass.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:food_delivery/widgets/recent_orders.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //DeliveryResponseData deliveryResponseData = new DeliveryResponseData();
  _buildNearlyRestaurant() {
    List<Widget> restaurantList = [];
    int i =0;
    print(deliveryResponseData.records.length);
    deliveryResponseData.records.forEach((Records restaurant) {
      restaurantList.add(
          GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                        width: 1.0,
                        color: Colors.grey[200]
                    )
                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                        child: Hero(
                            tag: deliveryResponseData.records[i].name,
                            child: Image.network(deliveryResponseData.records[i].image,
                              height: 200.0,
                              width: 450.0,
                              fit: BoxFit.cover,
                            )
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15.0, top: 12, bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              deliveryResponseData.records[i].name,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 4.0,),
                          // RatingStarts(rating: restaurant.rating, taille: 26.0,),
                          Text(
                            restaurant.destination_points[0].point_type,
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.0,),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    print(context);
                    return RestaurantScreen(restaurant: restaurant);
                  }
                ),
              ),
          )
      );
    i++;});

    return Column(children: restaurantList);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
//        appBar: AppBar(
//          centerTitle: true,
//          title: Text(""),
//          actions: <Widget>[
//            Stack(
//              alignment: Alignment.center,
//              children: <Widget>[
////                Container(
////                    padding: EdgeInsets.only(right: 5.0, bottom: 5.0, top: 5.0),
////                    margin: EdgeInsets.only(right: 5.0),
////                    child: FloatingActionButton(
////                        backgroundColor: Theme.of(context).primaryColor,
////                        tooltip: 'Корзина',
////                        isExtended: true,
////                        heroTag: "",
////                        child: Icon(
////                            Icons.shopping_cart,
////                            color: Colors.white,
////                            size: 30.0
////                        ),
////                        onPressed: () => Navigator.push(
////                            context,
////                            MaterialPageRoute(
////                                builder: (_) => CartScreen()
////                            )
////                        )
////                    )
////                ),
//                Positioned(
//                  bottom: 37.0,
//                  right: 30.0,
//                  child: Text(
//                      '${currentUser.cart.length}',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        color:  Colors.white,
//                        fontSize: 14.0,
//                        fontWeight: FontWeight.w600,
//                        //  letterSpacing: 1.2
//                      )
//                  ),
//                )
//              ],
//            ),
//          ],
//        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
              child: Row(
                children: <Widget>[
                  Image(image: AssetImage('assets/images/faem_pict.png'),),
                  Text("Еда", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),
                ],
              ),
            ),
//             Padding(
//               padding: EdgeInsets.all(18.0),
//               child: TextField(
//                  decoration: InputDecoration(
//                      contentPadding: EdgeInsets.symmetric(vertical: 15.0),
//                      fillColor: Colors.white,
//                      filled: true,
//                      border: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(30.0),
//                        borderSide: BorderSide(width: 0.8)
//                      ),
//                      enabledBorder: OutlineInputBorder(
//                        borderRadius: BorderRadius.circular(30.0),
//                        borderSide: BorderSide(width: 0.8, color: Theme.of(context).primaryColor)
//                      ),
//                      hintText: 'Search Food or Restaurants',
//                      prefixIcon: Icon(
//                        Icons.search,
//                        size: 30.0
//                      ),
//                      suffixIcon: IconButton(
//                        icon: Icon(Icons.clear),
//                        onPressed: () {},
//                      )
//                  ),
//                )
//             ),
            //RecentOrders(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                      'Все рестораны',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                      )
                  ),
                ),
                _buildNearlyRestaurant()
              ],
            )
          ],
        ),
      ),
    );
  }
}