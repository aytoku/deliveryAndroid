import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/PostData/restaurant_items_data_pass.dart';
import 'file:///C:/Users/GEOR/AndroidStudioProjects/newDesign/lib/buttons/bottm_button.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_list.dart';
import 'package:food_delivery/models/global_state.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/order_redister.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/scopped_model/food_bascket_model.dart';
import 'package:food_delivery/scopped_model/food_model.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:food_delivery/screens/add_card_screen.dart';
import 'package:food_delivery/screens/beverage_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/desert_screen.dart';
import 'package:food_delivery/screens/salad_screen.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class RestaurantScreen extends StatefulWidget{

  final Records restaurant;
  RestaurantScreen({Key key, this.restaurant}) : super(key: key);

  @override
  _RestaurantScreenState createState() => _RestaurantScreenState(restaurant, '');
}

class _RestaurantScreenState extends State<RestaurantScreen> {

final Records restaurant;
  String category;

GlobalKey<ButtonCounterState> buttonCounterKey = new GlobalKey();
GlobalKey<CounterState> counterKey = new GlobalKey();

  bool isLoading = true;

  @override
  void initStateColor() {
    super.initState();
    _color = true;
  }
  List<FoodRecords> food_records_items = new List<FoodRecords>();
  int page = 1;
  int limit = 12;

  String apple_pay = "Apple Pay";
  Food foood = Food();

  String name;
  double price;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  _RestaurantScreenState(this.restaurant, this.category);

  _buildMenuItem(FoodRecords restaurantDataItems) {
    GlobalKey<CartItemsQuantityState> cartItemsQuantityKey = new GlobalKey();
    CartItemsQuantity cartItemsQuantity = new CartItemsQuantity(
      key: cartItemsQuantityKey,
      restaurantDataItems: restaurantDataItems,
    );
    return Center(
      child: GestureDetector(
        onTap: (){
          _onPressedButton(restaurantDataItems, cartItemsQuantityKey);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              //width: 170,
              height: 165,
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8.0, // soften the shadow
                      spreadRadius: 3.0, //extend the shadow
                    )
                  ],
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
                          tag: restaurantDataItems.name,
                          child: Image.network(restaurantDataItems.image,
                            fit: BoxFit.cover,
                            height: 90.0,
                            width: 170.0,
                          )
                      )
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5.0, right: 5, top: 12, bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          restaurantDataItems.name,
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.0,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 4.0,),
                            // RatingStarts(rating: restaurant.rating, taille: 26.0,),
                            Text(
                              '${restaurantDataItems.price}',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: cartItemsQuantity,
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

  void _onPressedButton(FoodRecords food, GlobalKey<CartItemsQuantityState> cartItemsQuantityKey){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          )
        ),
        context: context,
        builder: (context){
          return Container(
              height: 500,
              child:  Container(
                child: _buildBottomNavigationMenu(food, cartItemsQuantityKey),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                    )
                ),
              )
          );
        });
  }

  Column _buildBottomNavigationMenu(FoodRecords restaurantDataItems, GlobalKey<CartItemsQuantityState> cartItemsQuantityKey){
    return Column(
      children: <Widget>[
        Align(
          child: Padding(
            padding: EdgeInsets.only(right: 0),
            child: Container(
              child: Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
                      child: Hero(
                          tag: restaurantDataItems.name,
                          child: Image.network(restaurantDataItems.image,
                            fit: BoxFit.cover,
                            height: 300.0,
                            width: 600.0,
                          )
                      )
                  ),
                  Container(
                    color: Color(0xFAFAFAFA),
                    height: 60,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(restaurantDataItems.comment, style: TextStyle(color: Color(0xB0B0B0B0), fontSize: 13),),
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 0.0, top: 10, bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Form(
                          key: _foodItemFormKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text(
                                    restaurantDataItems.name,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ),
                              SizedBox(height: 4.0,),
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    '${restaurantDataItems.price}',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 4.0,),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(top: 0),
                                child: Counter(
                                  key: counterKey,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20, top: 0),
                                child: FlatButton(
                                  child: Text("Добавить", style: TextStyle(color: Colors.white, fontSize: 15),),
                                  color: Colors.redAccent,
                                  splashColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 20),
                                  onPressed: ()
                                  {
                                    currentUser.cartDataModel.addItem(
                                        new Order(food: restaurantDataItems, quantity: counterKey.currentState.counter, restaurant: restaurant, date: DateTime.now().toString())
                                    );
                                    cartItemsQuantityKey.currentState.refresh();
                                    buttonCounterKey.currentState.refresh();
                                    counterKey.currentState.refresh();
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget foodList(String s){
    return Text(
        s,
        style: TextStyle(
        fontSize: 15.0,
        color: Color(0x99999999)
    ));
  }

  bool _color;

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  _buildFoodCategoryList(){
    return Flexible(
      flex: 1,
      fit: FlexFit.loose,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(restaurant.product_category.length, (index){
          return GestureDetector(child:Padding(
              padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
              child:Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: (restaurant.product_category[index] != category) ? Colors.white : Colors.redAccent),
                child:  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15, top: 5,),
                    child: Text(restaurant.product_category[index],
                      style: TextStyle(color: (restaurant.product_category[index] != category) ? Color(0x99999999) : Colors.white, fontSize: 15),)
                ),
              )
          ), onTap: (){
            setState(() {
              isLoading = true;
              page = 1;
              category = restaurant.product_category[index];
              _color = !_color;
            });
          },);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldStateKey,
      body: FutureBuilder<RestaurantDataItems>(
        future: loadRestaurantItems(restaurant.uuid, category, page, limit),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot<RestaurantDataItems> snapshot){
          print(snapshot.connectionState);
          if(snapshot.hasData){
            if(page == 1){
              this.food_records_items.clear();
            }
            if(snapshot.data.records_count == 0){
              return Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Padding(
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
                              ),
                              Flexible(
                                flex: 10,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0),
                                    child:  Text(this.restaurant.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    _buildFoodCategoryList(),
                    Container(
                        height: 500,
                        child: Center(
                          child: Text('Нет товаров данной категории'),
                        )
                    ),
                    SizedBox(height: 10.0),
                  ],
                )
              );
            }
            if(snapshot.connectionState == ConnectionState.done){
              food_records_items.addAll(snapshot.data.records);
              isLoading = false;
            }
            return Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: Padding(
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
                            ),
                            Flexible(
                              flex: 10,
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 0),
                                  child:  Text(this.restaurant.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  _buildFoodCategoryList(),
                  Flexible(
                    flex: 8,
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                          if(snapshot.data.records_count - (page + 1) * limit > (-1) * limit){
                           // snapshot = null;
                            setState(() {
                              isLoading = true;
                              page++;
                            });
                          }
                        }
                      },
                      child: GridView.count(
                        padding: EdgeInsets.all(10.0),
                        crossAxisCount: 2,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 10.0,
                        children: List.generate(food_records_items.length, (index) {
                          FoodRecords food = food_records_items[index];
                          return _buildMenuItem(food);
                        }),
                      )
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
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
                                  'Корзина',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white
                                  )
                              ),
                            )
                          ),
                          new ButtonCounter(
                            key: buttonCounterKey,
                          )
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
                          builder: (context) => new CartScreen(restaurant: restaurant),
                        ),
                      );},
                    ),
                  )
                ],
              ),
            );
          }
          else{
            return Center(
              child: CircularProgressIndicator(

              ),
            );
          }
        }
      ),
    );
  }
}

class CartItemsQuantity extends StatefulWidget {
  CartItemsQuantity({Key key, this.restaurantDataItems,}) : super(key: key);
  final FoodRecords restaurantDataItems;

  @override
  CartItemsQuantityState createState() {
    return new CartItemsQuantityState(restaurantDataItems);
  }
}

class CartItemsQuantityState extends State<CartItemsQuantity> {
  final FoodRecords restaurantDataItems;

  CartItemsQuantityState(this.restaurantDataItems);
  @override
  Widget build(BuildContext context) {
    int amount = 0;
    currentUser.cartDataModel.cart.forEach((element) {
      if(element.food.uuid == restaurantDataItems.uuid){
        amount = element.quantity;
      }
    });
    return  Padding(
      padding: EdgeInsets.only(left: 120),
      child: Text(
          '$amount',
          style: TextStyle(
            fontSize: 14.0,
            letterSpacing: 1.2,
          )
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}

class Counter extends StatefulWidget{
  Counter({Key key}) : super(key: key);

  @override
  CounterState createState() {
    return new CounterState();
  }
}

class CounterState extends State<Counter>{
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

  Widget build(BuildContext context){
    return  Padding(
      padding: EdgeInsets.only(top: 5, left: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xF5F5F5F5))
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    _incrementCounter_minus();
                  },child: SvgPicture.asset('assets/svg_images/minus.svg'),
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
              Padding(
                padding: EdgeInsets.only(right: 15, top: 15, bottom: 15),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _incrementCounter_plus();
                    });
                  },
                  child: SvgPicture.asset('assets/svg_images/plus_counter.svg'),
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

class ButtonCounter extends StatefulWidget {
  ButtonCounter({Key key}) : super(key: key);

  @override
  ButtonCounterState createState() {
    return new ButtonCounterState();
  }

}

class ButtonCounterState extends State<ButtonCounter> {

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);

    return  Flexible(
      flex: 1,
      child: Text(
          '${totalPrice.toStringAsFixed(0)}',
          style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: Colors.white
          )
      ),
    );
  }

  void refresh(){
    setState(() {

    });
  }
}