import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/PostData/orders_story_data.dart';
import 'package:food_delivery/PostData/restaurant_data_pass.dart';
import 'package:food_delivery/PostData/restaurant_items_data_pass.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/screens/infromation_screen.dart';
import 'package:food_delivery/screens/my_addresses_screen.dart';
import 'package:food_delivery/screens/orders_story_screen.dart';
import 'package:food_delivery/screens/payments_methods_screen.dart';
import 'package:food_delivery/screens/profile_screen.dart';
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
                    if(currentUser.cartDataModel.cart.length > 0 && currentUser.cartDataModel.cart[0].restaurant.uuid != restaurant.uuid){
                      currentUser.cartDataModel.cart.clear();
                    }
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
                  title: Text(necessaryDataForAuth.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: ListTile(
                  title: Text(necessaryDataForAuth.phone_number, style: TextStyle(color: Color(0x9B9B9B9B), fontSize: 14),),
                  trailing: GestureDetector(
                    child: SvgPicture.asset('assets/svg_images/pencil.svg'),
                    onTap: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new ProfileScreen(),
                        ),
                      );
                    },
                  ),
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
//                          Flexible(
//                            flex: 5,
//                            child: Padding(
//                              padding: EdgeInsets.only(left: 50,),
//                              child: GestureDetector(
//                                  child: Text(
//                                    'Указать адрес доставки',
//                                    style: TextStyle(
//                                        color: Colors.redAccent,
//                                        decoration: TextDecoration.underline,
//                                        fontSize: 14
//                                    ),
//                                  )
//                              ),
//                            ),
//                          ),
//                          Flexible(
//                            flex: 2,
//                            child: Padding(
//                              padding: EdgeInsets.only(left: 50),
//                              child: GestureDetector(
//                                child: SvgPicture.asset('assets/svg_images/search.svg')
//                              ),
//                            ),
//                          ),
                        ],
                      ),
                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Divider(height: 1.0, color: Color(0xEEEEEEEE)),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    RestaurantsCategory(),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Divider(height: 1.0, color: Color(0xEEEEEEEE)),
                    SizedBox(
                      height: 10,
                    ),
                    OrderChecking(),
                    SizedBox(
                      height: 10,
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

class OrderChecking extends StatefulWidget {
  OrderChecking({Key key}) : super(key: key);

  @override
  OrderCheckingState createState() {
    return new OrderCheckingState();
  }
}

class OrderCheckingState extends State<OrderChecking> {

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder<OrdersStoryModel>(
      future: loadOrdersStoryModel(),
      builder: (BuildContext context, AsyncSnapshot<OrdersStoryModel>snapshot){
        if(snapshot.hasData){
          if(snapshot.data.ordersStoryModelItems.length == 0){
            return Container();
          }
          return Container(
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
                borderRadius: BorderRadius.circular(17.0),
                border: Border.all(
                    width: 1.0,
                    color: Colors.grey[200]
                )
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12.0, top: 12, bottom: 12, right: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Ваш заказ из ' + (snapshot.data.ordersStoryModelItems.length != 0 ? snapshot.data.ordersStoryModelItems[0].store.name : 'Пусто'),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                                    color: Colors.redAccent),
                                child:  Padding(
                                    padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
                                    child: Text('На карте',
                                      style: TextStyle(color: Colors.white, fontSize: 15),)
                                ),
                              ),
                              onTap: (){
                                Navigator.push(
                                  context,
                                  new MaterialPageRoute(
                                      builder: (context) {
                                        return new OnMap();
                                      }
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 4.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                                  color: Color(0xF6F6F6F6)),
                              child:  Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                                    child: Text('Принят',
                                      style: TextStyle(color: Color(0x42424242), fontSize: 11),)
                                ),
                              )
                          ),
                          Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                                  color: Color(0xF6F6F6F6)),
                              child:  Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                                    child: Text('Принят',
                                      style: TextStyle(color: Color(0x42424242), fontSize: 11),)
                                ),
                              )
                          ),
                          Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                                  color: Color(0xF6F6F6F6)),
                              child:  Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                                    child: Text('Принят',
                                      style: TextStyle(color: Color(0x42424242), fontSize: 11),)
                                ),
                              )
                          ),
                          Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                                  color: Color(0xF6F6F6F6)),
                              child:  Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                    padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                                    child: Text('Принят',
                                      style: TextStyle(color: Color(0x42424242), fontSize: 11),)
                                ),
                              )
                          ),
                        ],
                      ),
                      SizedBox(height: 4.0,),
                    ],
                  ),
                )
              ],
            ),
          );
        }else{
          return Center(
            child: Container(),
          );
        }
      },
    );
  }
}

class RestaurantsCategory extends StatefulWidget {
  RestaurantsCategory({Key key}) : super(key: key);

  @override
  RestaurantsCategoryState createState() {
    return new RestaurantsCategoryState();
  }
}

class RestaurantsCategoryState extends State<RestaurantsCategory> {

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xF6F6F6F6)),
            child:  Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
                child: Text('Популярное',
                  style: TextStyle(color: Color(0x42424242), fontSize: 15),)
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xF6F6F6F6)),
            child:  Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
                child: Text('Фаст-фуд',
                  style: TextStyle(color: Color(0x42424242), fontSize: 15),)
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Color(0xF6F6F6F6)),
            child:  Padding(
                padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
                child: Text('Фаст-фуд',
                  style: TextStyle(color: Color(0x42424242), fontSize: 15),)
            ),
          ),
        ),
      ],
    );
  }
}

class OnMap extends StatefulWidget {
  @override
  OnMapState createState() => OnMapState();
}

class OnMapState extends State<OnMap> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        child: FloatingActionButton(
          child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _controller),
          elevation: 5,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          onPressed: () async {
            if (_controller.isDismissed)
              _controller.forward();
            else if (_controller.isCompleted)
              _controller.reverse();
          },
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 50),
                  child: SvgPicture.asset('assets/svg_images/close.svg'),
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              )
            ),
            SizedBox.expand(
              child: SlideTransition(
                position: _tween.animate(_controller),
                child: DraggableScrollableSheet(
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      color: Colors.white,
                      child: ListView(
                        controller: scrollController,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
                            child: Text('Курьер прибыл', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),),
                          ),
                          Divider(height: 1.0, color: Color(0xEDEDEDED)),
                          Padding(
                            padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                            child: Text('желтая LADA 2115'),
                          ),
                          Divider(height: 1.0, color: Color(0xEDEDEDED)),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 60,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 8.0, // soften the shadow
                                            spreadRadius: 3.0, //extend the shadow
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(11.0),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey[200]
                                        )
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: SvgPicture.asset('assets/svg_images/phone.svg'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text('Позвонить'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Container(
                                    height: 60,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 8.0, // soften the shadow
                                            spreadRadius: 3.0, //extend the shadow
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(11.0),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey[200]
                                        )
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: SvgPicture.asset('assets/svg_images/message.svg'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text('Чат'),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10,),
                          Divider(height: 1.0, color: Color(0xEDEDEDED)),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: SvgPicture.asset('assets/svg_images/i.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Text('Детали доставки'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Text('Стоимость 1054₽'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1.0, color: Color(0xEDEDEDED)),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: SvgPicture.asset('assets/svg_images/visa.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Text('Visa 9966'),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 0),
                                        child: Text('Изменить способ оплаты'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Color(0xEDEDEDED),
                            height: 30,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: SvgPicture.asset('assets/svg_images/mini_ellipse.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Шаурмания, МаксимаГорького, 23'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1.0, color: Color(0xEDEDEDED)),
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: SvgPicture.asset('assets/svg_images/mini_ellipse.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Шаурмания, МаксимаГорького, 23'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1.0, color: Color(0xEDEDEDED)),
                          Padding(
                            padding: EdgeInsets.only(top: 15, bottom: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: SvgPicture.asset('assets/svg_images/nav.svg'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Text('Показать где я'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                              ],
                            ),
                          ),
                          Divider(height: 1.0, color: Color(0xEDEDEDED)),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Container(
                                    height: 60,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 8.0, // soften the shadow
                                            spreadRadius: 3.0, //extend the shadow
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(11.0),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey[200]
                                        )
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: SvgPicture.asset('assets/svg_images/big_cross.svg'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text('Отменить'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Container(
                                    height: 60,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 8.0, // soften the shadow
                                            spreadRadius: 3.0, //extend the shadow
                                          )
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(11.0),
                                        border: Border.all(
                                            width: 1.0,
                                            color: Colors.grey[200]
                                        )
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: SvgPicture.asset('assets/svg_images/green_plus.svg'),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text('Заказать ещё'),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}