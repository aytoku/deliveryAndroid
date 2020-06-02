import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/PostData/restaurant_data_pass.dart';
import 'package:food_delivery/PostData/restaurant_items_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/infromation_screen.dart';
import 'package:food_delivery/screens/my_addresses_screen.dart';
import 'package:food_delivery/screens/orders_story_screen.dart';
import 'package:food_delivery/screens/payments_methods_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:food_delivery/screens/service_screen.dart';
import 'package:food_delivery/screens/ssettings_screen.dart';
import 'package:food_delivery/sideBar/side_bar.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:food_delivery/widgets/recent_orders.dart';

import 'auth_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int page = 1;
  int limit = 12;
  bool isLoading = true;
  List<Records> records_items = new List<Records>();
  String category;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _color;

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  _buildNearlyRestaurant() {
    List<Widget> restaurantList = [];
    int i =0;
    records_items.forEach((Records restaurant) {
      restaurantList.add(
          GestureDetector(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
                            tag: restaurant.uuid,
                            child: Image.network(restaurant.image,
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
                              restaurant.name,
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 4.0,),
                          Text(
                            (restaurant.destination_points != null)? restaurant.destination_points[0].type: ' ',
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
                    currentUser.cartDataModel.cart.clear();
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
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: ListTile(
                  title: Text(necessaryDataForAuth.phone_number, style: TextStyle(color: Colors.black),),
                ),
              ),
              ListTile(
                title: Text('Способы оплаты'),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new PaymentsMethodsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('История заказов'),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new OrdersStoryScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Мои адреса'),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new MyAddressesScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Настройки'),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new SettingsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Инфоромация'),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new InformationScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Служба поддержки'),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new ServiceScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text('Выход'),
                onTap: (){
                  NecessaryDataForAuth.clear().then((value){
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new AuthScreen(),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
        body:  FutureBuilder<DeliveryResponseData>(
            future: loadRestaurant(page, limit),
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot<DeliveryResponseData> snapshot){
              print(snapshot.connectionState);
              if(snapshot.hasData){
                if(page == 1){
                  this.records_items.clear();
                }
                if(snapshot.data.records_count == 0){
                  return Center(
                    child: Text('Нет товаров данной категории'),
                  );
                }
                if(snapshot.connectionState == ConnectionState.done){
                  records_items.addAll(snapshot.data.records);
                  isLoading = false;
                }
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 5),
                      child:Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: GestureDetector(
                                child: SvgPicture.asset('assets/svg_images/menu.svg'),
                                onTap: (){
                                  _scaffoldKey.currentState.openDrawer();
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.only(left: 50,),
                              child: GestureDetector(
                                  child: Text(
                                    'Указать адрес доставки',
                                    style: TextStyle(
                                        color: Colors.redAccent,
                                        decoration: TextDecoration.underline,
                                        fontSize: 14
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 50),
                              child: GestureDetector(
                                child: SvgPicture.asset('assets/svg_images/search.svg')
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
                                setState(() {
                                  isLoading = true;
                                  page++;
                                });
                              }
                            },
                            child: _buildNearlyRestaurant()
                        ),
                      ],
                    )
                  ],
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
      ),
    );
  }
}