import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  _RestaurantScreenState createState() => _RestaurantScreenState(restaurant);
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  final Records restaurant;

//  final int restaurant_index;
//  _RestaurantScreenState(this.restaurant_index);

  String apple_pay = "Apple Pay";
  Food foood = Food();

  String name;
  double price;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  _RestaurantScreenState(this.restaurant);


  void getData() async{
    Future<String> _loadRestaurantsItems() async {
      return await rootBundle.loadString('https://crm.apis.stage.faem.pro/api/v2/products');
    }

    Future loadRestaurantItems() async {
      String jsonString = await _loadRestaurantsItems();
      final jsonResponse = json.decode(jsonString);
      var response = await http.post(jsonResponse, body: {
        'store_uuid': 'e93ef119-001c-4b27-915a-c86d58790cbf',
        'page': '1',
        'limit': '12'
      });
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        RestaurantDataItems restaurantDataItems1 = new RestaurantDataItems.fromJson(jsonResponse);
        restaurantDataItems = restaurantDataItems1;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
      print('Response body: ${response.body}');
    }
  }


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

  _buildMenuItem(FoodRecords restaurantDataItems) {
    int i =0;
   // double taille = MediaQuery.of(context).size.width / 2.25;
    return Center(

      child: GestureDetector(
        onTap: (){
          _onPressedButton(restaurantDataItems);
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
                          tag: restaurantDataItems.name,
                          child: Image.network(restaurantDataItems.image,
                            fit: BoxFit.cover,
                            height: 170.0,
                            width: 170.0,)
                      )
                  ),
                  Container(
                    margin: EdgeInsets.all(12.0),
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

  void _onPressedButton(FoodRecords food){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
              color: Color(0xFF737373),
              height: 500,
              child:  Container(
                child: _buildBottomNavigationMenu(food),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30),
                      topRight: const Radius.circular(30),
                    )
                ),
              )
          );
        });
  }

  Column _buildBottomNavigationMenu(FoodRecords restaurantDataItems){
    int i = 0;
    return Column(
      children: <Widget>[
        Align(
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
                          tag: restaurantDataItems.name,
                          child: Image.network(restaurantDataItems.image,
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
                        Form(
                          key: _foodItemFormKey,
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Text(
                                  restaurantDataItems.name,
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
                                  '${restaurantDataItems.price}',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
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
//                                  Padding(
//                                      padding: EdgeInsets.only(top: 10, right: 20, left: 60, bottom: 6),
//                                      child: ScopedModelDescendant(
//                                        builder: (BuildContext context, Widget child, MainModel model){
//                                          return GestureDetector(
//                                            onTap: () {
//                                              onSubmit(model.addFood);
//                                              if (model.isLoading) {
//                                                // show loading progess indicator
//                                                showLoadingIndicator();
//                                              }
//                                            },
//                                            child: BottomButton(btnText: 'Добавить',),
//                                          );
//                                        },
//                                      )
//                                  ),
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
                                    onPressed: ()
                                    {
                                      currentUser.cart.add(
                                          new Order(food: restaurantDataItems, quantity: counter, restaurant: restaurant, date: DateTime.now().toString())
                                      );
                                    },
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
      ],
    );
  }

//  _showModalBottomSheet(Food food) {
//    showModalBottomSheet(
//      context: context,
//      builder: (BuildContext context) {
//        return  Container(
//          key: _scaffoldStateKey,
//          height: 400,
//          decoration: BoxDecoration(
//            color: Colors.white,
//            borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(20),
//              topRight: Radius.circular(20),
//            ),
//          ),
//          child:  Align(
//            child: Padding(
//              padding: EdgeInsets.only(right: 0),
//              child: Container(
////                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
////                decoration: BoxDecoration(
////                    color: Colors.white,
////                    borderRadius: BorderRadius.circular(0.0),
////                    border: Border.all(
////                        width: 1.0,
////                        color: Colors.grey[200]
////                    )
////                ),
//                child: Column(
//                  children: <Widget>[
//                    ClipRRect(
//                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0)),
//                        child: Hero(
//                            tag: food.name,
//                            child: Image(
//                              image: AssetImage(food.imagePath),
//                              fit: BoxFit.cover,
//                              height: 170.0,
//                              width: 600.0,
//                            )
//                        )
//                    ),
//                    Container(
//                      margin: EdgeInsets.only(right: 10.0, top: 12, bottom: 12),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Form(
//                            key: _foodItemFormKey,
//                            child: Row(
//                              children: <Widget>[
//                                Padding(
//                                  padding: EdgeInsets.only(left: 15),
//                                  child: Text(
//                                    food.name,
//                                    style: TextStyle(
//                                        fontSize: 15.0,
//                                        fontWeight: FontWeight.bold
//                                    ),
//                                    overflow: TextOverflow.ellipsis,
//                                  ),
//                                ),
//                                SizedBox(height: 4.0,),
//                                // RatingStarts(rating: restaurant.rating, taille: 26.0,),
//                                Padding(
//                                  padding: EdgeInsets.only(left: 220),
//                                  child: Text(
//                                    '${food.price}',
//                                    style: TextStyle(
//                                        fontSize: 12.0,
//                                        fontWeight: FontWeight.w600
//                                    ),
//                                    overflow: TextOverflow.ellipsis,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          SizedBox(height: 4.0,),
//                          Padding(
//                            padding: EdgeInsets.only(top: 60),
//                            child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: [
//                                  GestureDetector(
//                                    onTap: () {
//                                      _incrementCounter_minus();
//                                    },child: Text(
//                                    '-',
//                                    style: TextStyle(
//                                      fontSize: 24.0,
//                                      fontWeight: FontWeight.w600,
//                                      color: Colors.black,
//                                    ),
//                                  ),
//                                  ),
//                                  SizedBox(width: 20.0),
//                                  Padding(
//                                    padding: EdgeInsets.only(right: 20),
//                                    child: Text(
//                                      '$counter',
//                                      style: TextStyle(
//                                        fontSize: 20.0,
//                                        fontWeight: FontWeight.w600,
//                                      ),
//                                    ),
//                                  ),
//
//                                  GestureDetector(
//                                    onTap: () {
//                                      setState(() {
//                                        _incrementCounter_plus();
//                                      });
//                                    },
//                                    child: Text(
//                                      '+',
//                                      style: TextStyle(
//                                        fontSize: 24.0,
//                                        fontWeight: FontWeight.w600,
//                                        color: Colors.black,
//                                      ),
//                                    ),
//                                  ),
////                                  Padding(
////                                      padding: EdgeInsets.only(top: 10, right: 20, left: 60, bottom: 6),
////                                      child: ScopedModelDescendant(
////                                        builder: (BuildContext context, Widget child, MainModel model){
////                                          return GestureDetector(
////                                            onTap: () {
////                                              onSubmit(model.addFood);
////                                              if (model.isLoading) {
////                                                // show loading progess indicator
////                                                showLoadingIndicator();
////                                              }
////                                            },
////                                            child: BottomButton(btnText: 'Добавить',),
////                                          );
////                                        },
////                                      )
////                                  ),
//                                  Padding(
//                                    padding: EdgeInsets.only(left: 30),
//                                    child: FlatButton(
//                                      child: Text("Добавить", style: TextStyle(color: Colors.white, fontSize: 15),),
//                                      color: Colors.red,
//                                      splashColor: Colors.red,
//                                      shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(20),
//                                      ),
//                                      padding: EdgeInsets.only(left: 80, top: 20, right: 80, bottom: 20),
//                                      onPressed: (){
//                                        currentUser.cart.add(
//                                            new Order(food: food, quantity: counter, restaurant: widget.restaurant, date: DateTime.now().toString())
//                                        );
//                                        _snack(food);},
//                                    ),
//                                  )
//                                ]
//                            ),
//                          ),
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,

      onChanged: (String value) {
        if (hint == foood.name) {
          name = value;
        }
      },
    );
  }

  _buildList(){
    List<String> list = new List<String>();
    double totalPrice = 0;
    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
    return Expanded(
      child: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              ListTile(
                title: Text('Сэндвичи', style: TextStyle(color: Colors.black),),
              ),
            ],
          ),
        ],
      )
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

  bool _color;

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key : _scaffoldStateKey,
      body: FutureBuilder<RestaurantDataItems>(
        future: loadRestaurantItems(this.restaurant.uuid),
        // ignore: missing_return
        builder: (BuildContext context, AsyncSnapshot<RestaurantDataItems> snapshot){
          //loadRestaurantItems();
         //print('${snapshot.hasData}');
          if(snapshot.hasData){
            return Container(
              color: Colors.white,
              child: Column(
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
                        padding: EdgeInsets.only(top: 50),
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
                                  child: Image(
                                    width: 30,
                                    height: 30,
                                    image: AssetImage('assets/images/arr.png'),
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(right: 115),
                                child:  Text(this.restaurant.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              ),
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
                    padding: EdgeInsets.only(top: 25),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(restaurant.product_category[0], style: TextStyle(color: Color(0x99999999), fontSize: 15),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(restaurant.product_category[1], style: TextStyle(color: Color(0x99999999), fontSize: 15),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(restaurant.product_category[2], style: TextStyle(color: Color(0x99999999), fontSize: 15),),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(restaurant.product_category[3], style: TextStyle(color: Color(0x99999999), fontSize: 15),),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Center(
                      child: Text(
                          'Сэндвичи',
                          style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  Expanded(
                      child: GridView.count(
                        padding: EdgeInsets.all(10.0),
                        crossAxisCount: 1,
                        crossAxisSpacing: 15.0,
                        children: List.generate(snapshot.data.records.length, (index) {
                          FoodRecords food = snapshot.data.records[index];
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
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      ),
    );
  }

  void onSubmit(Function addFood) async{
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      final Food food = Food(
        name: foood.name,
        price: foood.price,
      );
      bool value = await addFood(food);
      if(value){
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
            content: Text("Заказ прошел успешно")
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }else if(!value){
        Navigator.of(context).pop();
        SnackBar snackBar = SnackBar(
            content: Text("Произошел сбой")
        );
        _scaffoldStateKey.currentState.showSnackBar(snackBar);
      }
    }
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
                Text("Добавляется в корзину"),
              ],
            ),
          );
        }
    );
  }
}

class Screen1 extends StatefulWidget {
  @override
  Screen1State createState() {
    return new Screen1State();
  }
}

class Screen1State extends State<Screen1> {
  bool _color;

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Card(
            color: _color ? Colors.deepOrangeAccent : Colors.purpleAccent,
            child: ListTile(
              onTap: () {
                setState(() {
                  _color = !_color;
                });
              },
              title: Text(
                'Title',
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Subtitle',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ));
  }
}