import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_list.dart';
import 'package:food_delivery/models/global_state.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/models/salad.dart';
import 'package:food_delivery/screens/add_card_screen.dart';
import 'package:food_delivery/screens/beverage_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/desert_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';

class SaladScreen extends StatefulWidget {

  final Salad restaurant;

  SaladScreen({this.restaurant});

  @override
  _SaladScreenState createState() => _SaladScreenState();
}

class _SaladScreenState extends State<SaladScreen> {

  String apple_pay = "Apple Pay";

  @override
  void initStateModal(){
    apple_pay = new TextEditingController() as String;
    _store.set('name', '');
    apple_pay = _store.get('name');
  }

  onClickBtn(){
    _store.set('name', apple_pay);
    Navigator.of(context).pushNamed('/Create');
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalState _store = GlobalState.instance;
  TextEditingController _name;

  @override
  void initState(){
    _name = TextEditingController(text: "");
  }

  int counter = 1;
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

  _buildMenuItem(Food menuItem) {

    // double taille = MediaQuery.of(context).size.width / 2.25;
    return Center(

        child: GestureDetector(
          onTap: (){
            _showModalBottomSheet(menuItem);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 170,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                            tag: menuItem.name,
                            child: Image(
                              image: AssetImage(menuItem.imageUrl),
                              fit: BoxFit.cover,
                              height: 170.0,
                              width: 170.0,
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
//                            Positioned(
//                              //bottom: 10.0,
//                                left: 90.0,
//                                child: Container(
//                                  width: 20.0,
////                                decoration: BoxDecoration(
////                                    color: Theme.of(context).primaryColor,
////                                    borderRadius: BorderRadius.circular(30.0)
////                                ),
//                                  child: IconButton(
//                                    icon: Icon(Icons.add),
//                                    iconSize: 15.0,
//                                    color: Colors.black,
//                                    onPressed: () {
//                                      currentUser.cart.add(
//                                          new Order(food: menuItem, quantity: 1, restaurant: widget.restaurant, date: DateTime.now().toString())
//                                      );
//                                      _snack(menuItem);
//                                    },
//                                  ),
//                                )
//                            ),
                              Padding(
                                padding: EdgeInsets.only(left: 90),
                                child: Text(
                                    '${currentUser.cart.length}',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      letterSpacing: 1.2,
                                    )
                                ),
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
        )
    );
  }

  _showModalBottomSheet(Food food) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
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
              child: Container(
//                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//                decoration: BoxDecoration(
//                    color: Colors.white,
//                    borderRadius: BorderRadius.circular(0.0),
//                    border: Border.all(
//                        width: 1.0,
//                        color: Colors.grey[200]
//                    )
//                ),
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                        child: Hero(
                            tag: food.name,
                            child: Image(
                              image: AssetImage(food.imageUrl),
                              fit: BoxFit.cover,
                              height: 170.0,
                              width: 600.0,
                            )
                        )
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 10.0, top: 12, bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  food.name,
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 4.0,),
                              // RatingStarts(rating: restaurant.rating, taille: 26.0,),
                              Padding(
                                padding: EdgeInsets.only(left: 220),
                                child: Text(
                                  '${food.price}',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0,),
                          Padding(
                            padding: EdgeInsets.only(top: 60),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _incrementCounter_minus();
                                    },child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ),
                                  SizedBox(width: 20.0),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Text(
                                      '$counter',
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _incrementCounter_plus();
                                      });
                                    },
                                    child: Text(
                                      '+',
                                      style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30),
                                    child: FlatButton(
                                      child: Text("Добавить", style: TextStyle(color: Colors.white, fontSize: 15),),
                                      color: Colors.red,
                                      splashColor: Colors.red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: EdgeInsets.only(left: 80, top: 20, right: 80, bottom: 20),
                                      onPressed: (){
                                        currentUser.cart.add(
                                            new Order(food: food, quantity: counter, date: DateTime.now().toString())
                                        );
                                        _snack(food);},
                                    ),
                                  )
                                ]
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

  Widget foodList(String s){
    return Text(
        s,
        style: TextStyle(
            fontSize: 15.0,
            color: Color(0x99999999)
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Padding(
                      padding: EdgeInsets.only(right: 15),
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
                      padding: EdgeInsets.only(right: 80),
                      child:  Text(widget.restaurant.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                    ),

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
                Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RestaurantScreen(),
                        ),
                      ),
                      child:Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: foodList('Сэндвичи'),
                      ),
                    ),GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SaladScreen(),
                        ),
                      ),
                      child:Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: foodList('Салаты'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DesertScreen(),
                        ),
                      ),
                      child:Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: foodList('Десерт'),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BeverageScreen(),
                        ),
                      ),
                      child:Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: foodList('Напитки'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 6.0),
          Center(
            child: Text(
                'Салаты',
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
                crossAxisSpacing: 15.0,
                children: List.generate(widget.restaurant.menu.length, (index) {
                  Food food = widget.restaurant.menu[index];
                  return _buildMenuItem(food);
                }),
              )
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
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
                        'Корзина',
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
                        '588 Р',
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
              padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
              onPressed: (){Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new CartScreen(),
                ),
              );},
            ),
          )
//          Center(
//            child: Text(
//                'Корзина (${currentUser.cart.length})',
//                style: TextStyle(
//                    fontSize: 22.0,
//                    fontWeight: FontWeight.w600,
//                    letterSpacing: 1.2,
//                )
//            ),
//          ),
        ],
      ),
    );
  }
}