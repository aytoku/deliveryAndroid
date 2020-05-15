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
  _RestaurantScreenState createState() => _RestaurantScreenState(restaurant, '');
}

class _RestaurantScreenState extends State<RestaurantScreen> {

  final Records restaurant;
  String category;

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

  CartItemsQuantity cartItemsQuantity = new CartItemsQuantity();

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
                            //cartItemsQuantity
                            Padding(
                              padding: EdgeInsets.only(left: 110),
                              child: Text(
                                  '${currentUser.cart.length}',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    letterSpacing: 1.2,
                                  )
                              ),
                            )
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
          )
        ),
        context: context,
        builder: (context){
          return Container(
              height: 450,
              child:  Container(
                child: _buildBottomNavigationMenu(food),
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

  Column _buildBottomNavigationMenu(FoodRecords restaurantDataItems){
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
                            height: 200.0,
                            width: 600.0,
                          )
                      )
                  ),
                  Container(
                    height: 30,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Text(restaurantDataItems.comment, style: TextStyle(color: Color(0xB0B0B0B0), fontSize: 13),),
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10.0, top: 10, bottom: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Form(
                          key: _foodItemFormKey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Align(
                                alignment: AlignmentDirectional.centerEnd,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 0),
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
                          padding: EdgeInsets.only(top: 20, left: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _incrementCounter_minus();
                                  },child: Text(
                                  '-',
                                  style: TextStyle(
                                    fontSize: 40.0,
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
                                    padding: EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 20),
                                    onPressed: ()
                                    {
                                      setState(() {
                                        currentUser.cart.add(
                                            new Order(food: restaurantDataItems, quantity: counter, restaurant: restaurant, date: DateTime.now().toString())
                                        );
                                      });
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
    double totalPrice = 0;
    currentUser.cart.forEach((Order order) => totalPrice += order.quantity * order.food.price);
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
              return Center(
                child: Text('Нет товаров данной категории'),
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
//                  Flexible(
//                    flex: 8,
//                      child: GridView.count(
//                        padding: EdgeInsets.all(10.0),
//                        crossAxisCount: 1,
//                        mainAxisSpacing: 8.0,
//                        crossAxisSpacing: 15.0,
//                        children: List.generate(snapshot.data.records.length, (index) {
//                          FoodRecords food = snapshot.data.records[index];
//                          return _buildMenuItem(food);
//                        }),
//                      )
//                  ),
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
                      padding: EdgeInsets.only(left: 10, top: 20, right: 10, bottom: 20),
                      onPressed: (){Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new CartScreen(),
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

class CartItemsQuantity extends StatefulWidget {
  @override
  CartItemsQuantityState createState() {
    return new CartItemsQuantityState();
  }
}

class CartItemsQuantityState extends State<CartItemsQuantity> {

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(left: 120),
      child: Text(
          '${currentUser.cart.length}',
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