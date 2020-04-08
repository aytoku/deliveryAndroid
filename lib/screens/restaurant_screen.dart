import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/widgets/rating_starts.dart';

class RestaurantScreen extends StatefulWidget {

  final Restaurant restaurant;

  RestaurantScreen({this.restaurant});

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _buildMenuItem(Food menuItem) {

    double taille = MediaQuery.of(context).size.width / 2.25;
    return Center(
      child: Column(
        //alignment: Alignment.center,
        children: <Widget>[
          Container(
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
                    borderRadius: BorderRadius.circular(15.0),
                    child: Hero(
                        tag: menuItem.name,
                        child: Image(
                          image: AssetImage(menuItem.imageUrl),
                          fit: BoxFit.cover,
                          height: 170.0,
                          width: 400.0,
                        )
                    )
                ),
                Container(
                  margin: EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        menuItem.name,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.0,),
                      Row(
                        children: <Widget>[
                          SizedBox(height: 4.0,),
                          // RatingStarts(rating: restaurant.rating, taille: 26.0,),
                          Text(
                            '${menuItem.price}',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Positioned(
                            //bottom: 10.0,
                              right: 10.0,
                              child: Container(
                                width: 48.0,
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(30.0)
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  iconSize: 30.0,
                                  color: Colors.white,
                                  onPressed: () {
                                    currentUser.cart.add(
                                        new Order(food: menuItem, quantity: 1, restaurant: widget.restaurant, date: DateTime.now().toString())
                                    );
                                    _snack(menuItem);
                                  },
                                ),
                              )
                          ),
                          Text(
                              '${currentUser.cart.length}',
                              style: TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _snack(Food menuItem) {
    SnackBar snackBar = new SnackBar(
      backgroundColor: Theme.of(context).primaryColor,
      content:Text(
        '${menuItem.name} добавлено в корзину',
        style: TextStyle(
            fontWeight: FontWeight.w600
        ),
      ),
      elevation: 1.0,
      action: SnackBarAction(
        label: "удалить",
        textColor: Colors.white,
        onPressed: () {
          currentUser.cart.removeAt(currentUser.cart.length-1);
        },

      ),
    );

    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldKey,
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
//              Hero(
//                tag: widget.restaurant.name,
//                child:  Image(
//                    height: 200.0,
//                    width: MediaQuery.of(context).size.width,
//                    fit: BoxFit.cover,
//                    image: AssetImage(widget.restaurant.imageUrl),
//                  )
//              ) ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      child: Image(
                        image: AssetImage('assets/images/arr.png'),
                      ),
                      onPressed: () {Navigator.pop(context);},
                    ),
                    Text(widget.restaurant.name)
                    //Text("Sandwich Street")
//                      IconButton(
//                      icon: Icon(Icons.favorite),
//                      color: Theme.of(context).primaryColor,
//                      iconSize: 50.0,
//                      onPressed: () {},
//                    )
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Text(
//                      widget.restaurant.name,
//                      style: TextStyle(
//                        fontSize: 22.0,
//                        fontWeight: FontWeight.w600
//                      )
//                    ),
//                    Text(
//                    '0.2 miles away',
//                      style: TextStyle(
//                        fontSize: 18.0,
//                      )
//                    )
//                  ],
//                ),
                //RatingStarts(rating: widget.restaurant.rating, taille: 35.0,),
//                SizedBox(height: 6.0,),
//                Text(
//                    widget.restaurant.address,
//                    style: TextStyle(
//                        fontSize: 15.0
//                    )
//                )
              ],
            ),
          ),
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//            FlatButton(
//                padding: EdgeInsets.symmetric(horizontal: 30.0),
//                color: Theme.of(context).primaryColor,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(10.0)
//                ),
//                child: Text(
//                  'Reviews',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 20.0
//                  )
//                ),
//                onPressed: () {},
//              ),
//            FlatButton(
//                padding: EdgeInsets.symmetric(horizontal: 30.0),
//                color: Theme.of(context).primaryColor,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.circular(10.0)
//                ),
//                child: Text(
//                  'Contact',
//                  style: TextStyle(
//                    color: Colors.white,
//                    fontSize: 20.0
//                  )
//                ),
//                onPressed: () {},
//              ),
//            ],
//          ),
          SizedBox(height: 6.0),
          Center(
            child: Text(
                'Сэндвичи',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2
                )
            ),
          ),
          SizedBox(height: 10.0,),
          Expanded(
              child: GridView.count(
                padding: EdgeInsets.all(10.0),
                crossAxisCount: 1,
                //  crossAxisSpacing: 15.0,
                children: List.generate(widget.restaurant.menu.length, (index) {
                  Food food = widget.restaurant.menu[index];
                  return _buildMenuItem(food);
                }),
              )
          ),
          SizedBox(height: 10.0),
          Center(
            child: Text(
                'Корзина (${currentUser.cart.length})',
                style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                )
            ),
          ),
        ],
      ),
    );
  }
}