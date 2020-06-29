import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/PostData/chat.dart';
import 'package:food_delivery/PostData/fcm.dart';
import 'package:food_delivery/PostData/orders_story_data.dart';
import 'package:food_delivery/PostData/restaurant_data_pass.dart';
import 'package:food_delivery/PostData/restaurant_items_data_pass.dart';
import 'package:food_delivery/PostData/test_fcm.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ChatHistoryModel.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/QuickMessagesModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/TestFCM.dart';
import 'package:food_delivery/models/firebase_notification_handler.dart';
import 'package:food_delivery/models/order.dart';
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
import 'package:url_launcher/url_launcher.dart';

import 'auth_screen.dart';
import 'cart_screen.dart';
import 'orders_details.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() : super(key: homeScreenKey);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  List<OrderChecking> orderList;
  int page = 1;
  int limit = 12;
  bool isLoading = true;
  List<Records> records_items = new List<Records>();
  String category;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey<BasketButtonState> basketButtonStateKey = new GlobalKey<BasketButtonState>();
  bool _color;


  @override
  void initState() {
    super.initState();
    _color = true;
  }

  _buildNearlyRestaurant() {
    List<Widget> restaurantList = [];
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
//                    if(currentUser.cartDataModel.cart.length > 0 && currentUser.cartDataModel.cart[0].restaurant.uuid != restaurant.uuid){
//                      currentUser.cartDataModel.cart.clear();
//                    }
                    return RestaurantScreen(restaurant: restaurant);
                  }
              ),
            ),
          )
      );
    });

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
//              ListTile(
//                title: Text('Способы оплаты'),
//                onTap: (){
//                  Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                      builder: (context) => new PaymentsMethodsScreen(),
//                    ),
//                  );
//                },
//              ),
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
//              ListTile(
//                title: Text('Настройки'),
//                onTap: (){
//                  Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                      builder: (context) => new SettingsScreen(),
//                    ),
//                  );
//                },
//              ),
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
                return NotificationListener<ScrollNotification>(
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
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 40, bottom: 10, left: 5),
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
//                      GestureDetector(
//                        child: Container(
//                          color: Colors.red,
//                          height: 60,
//                          width: 100,
//                          child: Text('asdasd'),
//                        ),
//                        onTap: ()async {
//                          await loadTestFCM(FCMToken, 'chat_message');
//                          //launch("tel://+79187072154");
//                        },
//                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder<List<OrderChecking>>(
                        future: OrderChecking.getActiveOrder(),
                        builder: (BuildContext context, AsyncSnapshot<List<OrderChecking>> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
                            orderList = snapshot.data;
                            return Container(
                              height: 200,
                              child: ListView(
                                children: snapshot.data,
                                scrollDirection: Axis.horizontal,
                              ),
                            );
                          }else{
                            orderList = null;
                            return Center(
                              child: Container(
                                height: 5,
                              ),
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView(
                          children: <Widget>[
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
                              ],
                            ),
                            _buildNearlyRestaurant()
                          ],
                        ),
                      ),
                      (currentUser.cartDataModel.cart != null && currentUser.cartDataModel.cart.length != 0) ?
                      BasketButton(key: basketButtonStateKey, restaurant: currentUser.cartDataModel.cart[0].restaurant,):
                          Container()
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
      ),
    );
  }
}

class OrderChecking extends StatefulWidget {
  final OrdersStoryModelItem ordersStoryModelItem;
  OrderChecking({Key key, this.ordersStoryModelItem}) : super(key: key);
  static var state_array = [
    'waiting_for_confirmation',
    'cooking',
    'offer_offered',
    'smart_distribution',
    'finding_driver',
    'offer_rejected',
    'order_start',
    'on_place',
    'on_the_way',
    'order_payment'
  ];

  @override
  OrderCheckingState createState() {
    return new OrderCheckingState(ordersStoryModelItem);
  }

  static Future<List<OrderChecking>> getActiveOrder() async{
    List<OrderChecking> activeOrderList = new List<OrderChecking>();
    OrdersStoryModel ordersStoryModel = await loadOrdersStoryModel();
    orderCheckingStates.clear();
    ordersStoryModel.ordersStoryModelItems.forEach((OrdersStoryModelItem element) {
      if(state_array.contains(element.state)){
        print(element.uuid);
        GlobalKey<OrderCheckingState> key = new GlobalKey<OrderCheckingState>();
        orderCheckingStates[element.uuid] = key;
        activeOrderList.add(new OrderChecking(ordersStoryModelItem: element, key: key,));
      }
    });
    return activeOrderList;
  }
}

class OrderCheckingState extends State<OrderChecking> {

  final OrdersStoryModelItem ordersStoryModelItem;
  OrderCheckingState(this.ordersStoryModelItem);

  @override
  Widget build(BuildContext context) {
    var processing = ['waiting_for_confirmation'];
    var cooking_state = ['cooking','offer_offered','smart_distribution', 'finding_driver', 'offer_rejected', 'order_start','on_place'];
    var in_the_way = ['on_the_way'];
    var take = ['order_payment'];
    //return Text('Ваш заказ из ' + (ordersStoryModelItem.store != null ? ordersStoryModelItem.store.name : 'Пусто'),);
    if(!OrderChecking.state_array.contains(ordersStoryModelItem.state)){
      return Container();
    }
    return  Container(
      height: 100,
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
          Expanded(
            child: Row(
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Align(
                      child: Text(
                        'Ваш заказ из ' + (ordersStoryModelItem.store != null ? ordersStoryModelItem.store.name : 'Пусто'),
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 5, left: 10, top: 20),
                    child: GestureDetector(
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Color(0xF6F6F6F6)),
                        child:  Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 0),
                            child: Text('Заказ',
                              style: TextStyle(color: Colors.black, fontSize: 15),)
                        ),
                      ),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) {
                                return OrdersDetailsScreen(ordersStoryModelItem: ordersStoryModelItem);
                              }
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: (processing.contains(ordersStoryModelItem.state)) ? Colors.lightBlueAccent : Color(0xF6F6F6F6)),
                        child:  Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: (processing.contains(ordersStoryModelItem.state)) ? SvgPicture.asset('assets/svg_images/white_clock.svg') : SvgPicture.asset('assets/svg_images/clock.svg'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text('Обработка',
                                style: (processing.contains(ordersStoryModelItem.state)) ? TextStyle(color: Colors.white, fontSize: 11) : TextStyle(color: Color(0x42424242), fontSize: 11)),
                            )
                          ],
                        ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                          color: (cooking_state.contains(ordersStoryModelItem.state)) ? Colors.green : Color(0xF6F6F6F6)),
                      child:  Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: (cooking_state.contains(ordersStoryModelItem.state)) ? SvgPicture.asset('assets/svg_images/white_bell.svg') : SvgPicture.asset('assets/svg_images/bell.svg'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text('Готовится',
                              style: (cooking_state.contains(ordersStoryModelItem.state)) ? TextStyle(color: Colors.white, fontSize: 11) : TextStyle(color: Color(0x42424242), fontSize: 11)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                          color: Color(0xF6F6F6F6)),
                      child:  Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: (in_the_way.contains(ordersStoryModelItem.state)) ? SvgPicture.asset('assets/svg_images/light_car.svg') : SvgPicture.asset('assets/svg_images/car.svg'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text('В пути',
                              style: (in_the_way.contains(ordersStoryModelItem.state)) ? TextStyle(color: Colors.black, fontSize: 11) : TextStyle(color: Color(0x42424242), fontSize: 11)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(60)),
                          color: (take.contains(ordersStoryModelItem.state)) ? Colors.redAccent : Color(0xF6F6F6F6)),
                      child:  Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: (take.contains(ordersStoryModelItem.state)) ? SvgPicture.asset('assets/svg_images/white_ready.svg') : SvgPicture.asset('assets/svg_images/ready.svg'),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text('Заберите',
                              style: (take.contains(ordersStoryModelItem.state)) ? TextStyle(color: Colors.white, fontSize: 11) : TextStyle(color: Color(0x42424242), fontSize: 11)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, right: 30, left: 10),
                      child: (in_the_way.contains(ordersStoryModelItem.state)) ? Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11)),
                            border: Border.all(color: Colors.green),
                            color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SvgPicture.asset('assets/svg_images/phone.svg'),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Позвонить',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ) : Container(),
                    ),
                    onTap: (){
                      launch("tel://" + ordersStoryModelItem.driver.phone);
                    },
                  )
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 10),
                      child: (in_the_way.contains(ordersStoryModelItem.state)) ? Container(
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            color: Colors.green),
                        child: Padding(
                          padding: EdgeInsets.only(top: 5, right: 10, bottom: 5, left: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: SvgPicture.asset('assets/svg_images/chat.svg'),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 25),
                                child: Text(
                                  'Чат',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.white
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ) : Container(),
                    ),
                    onTap: (){
                      Navigator.pushReplacement(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new ChatScreen(order_uuid: ordersStoryModelItem.uuid, key: chatKey),
                        ),
                      );
                    },
                  )
              ),
            ],
          )
        ],
      )
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


// ignore: must_be_immutable
class ChatScreen extends StatefulWidget {
  String order_uuid;
  ChatScreen({Key key, this.order_uuid}) : super(key: key);

  @override
  ChatScreenState createState() {
    return new ChatScreenState(order_uuid);
  }
}

class ChatScreenState extends State<ChatScreen> {

  List<ChatMessageScreen>chatMessageList;
  String order_uuid;
  ChatScreenState(this.order_uuid);
  TextEditingController messageField = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  buildChat(){
    List<String> messagedUuid = new List<String>();
    chatMessageList.forEach((element) {
      if(element.chatMessage.to == 'client' && element.chatMessage.ack == false){
        element.chatMessage.ack = false;
        messagedUuid.add(element.chatMessage.uuid);
      }
    });
    if(messagedUuid.length > 0){
      Chat.readMessage(messagedUuid);
    }
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 0, top: 40),
                        child: Container(
                            width: 40,
                            height: 40,
                            child: Center(
                              child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                            )
                        )
                    )
                ),
                onTap: (){
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new HomeScreen(),
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 40, left: 90),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Center(
                    child: Text(
                      'Чат с водителем',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                )
              )
            ]
          ),
          Flexible(
            flex: 10,
            child: new ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: chatMessageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return chatMessageList[index];
                },
                //chatMessageList
            ),
          ),
          Flexible(
            flex: 1,
            child: QuickMessageScreen(messageField: messageField,),
          ),
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 15, bottom: 10),
              child: Container(
                height: 40,
                width: 320,
                child: TextField(
                  controller: messageField,
                  decoration: InputDecoration(
                    suffix: GestureDetector(
                      child: SvgPicture.asset('assets/svg_images/send_message.svg'),
                      onTap: () async {
                        var message = await Chat.sendMessage(order_uuid, messageField.text, 'driver');
                        chatMessagesStates.forEach((key, value) {
                          print(key + ' ' + value.currentState.toString());
                        });
                        setState(() {
                          GlobalKey<ChatMessageScreenState>chatMessageScreenStateKey = new GlobalKey<ChatMessageScreenState>();
                          chatMessagesStates[message.uuid] = chatMessageScreenStateKey;
                          chatMessageList.insert(0, new ChatMessageScreen(key : chatMessageScreenStateKey,chatMessage: message));
                        });
                      },
                    ),
                  ),
                ),
              ),
            )
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    if(chatMessageList != null){
      print(chatMessageList.length);
      return buildChat();
    }
    return FutureBuilder<ChatHistoryModel>(
      future: Chat.loadChatHistory(order_uuid, 'driver'),
      builder: (BuildContext context, AsyncSnapshot<ChatHistoryModel> snapshot) {
        print('tututuwapatututuwapa ' + order_uuid);
        if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
          chatMessagesStates.clear();
          chatMessageList = new List<ChatMessageScreen>();
          snapshot.data.chatMessageList.forEach((element) {
            GlobalKey<ChatMessageScreenState>chatMessageScreenStateKey = new GlobalKey<ChatMessageScreenState>();
            chatMessagesStates[element.uuid] = chatMessageScreenStateKey;
            chatMessageList.add(new ChatMessageScreen(chatMessage: element, key: chatMessageScreenStateKey));
          });
          GlobalKey<ChatMessageScreenState>chatMessageScreenStateKey = new GlobalKey<ChatMessageScreenState>();
          chatMessagesStates['123'] = chatMessageScreenStateKey;
          chatMessageList.add(new ChatMessageScreen(key: chatMessageScreenStateKey, chatMessage: new ChatMessage(message: 'halo', ack: false, uuid: '123', from: 'driver', to: 'client')));
          return buildChat();
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class ChatMessageScreen extends StatefulWidget {

  ChatMessage chatMessage;
  ChatMessageScreen({Key key, this.chatMessage}) : super(key: key);

  @override
  ChatMessageScreenState createState() {
    return new ChatMessageScreenState(chatMessage);
  }
}

class ChatMessageScreenState extends State<ChatMessageScreen> {

  ChatMessage chatMessage;
  ChatMessageScreenState(this.chatMessage);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: <Widget>[
          (chatMessage.to == 'client') ? Padding(
            padding: EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(17.0),
                      border: Border.all(
                          width: 1.0,
                          color: Colors.grey
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(chatMessage.message,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color:Colors.black,
                          fontSize: 15,
                          decoration: TextDecoration.none
                      ),
                    ),
                  )
                ),
              ),
            ),
          ): Padding(
            padding: EdgeInsets.only(left: 15),
            child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(top: 10,bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(17.0),
                        border: Border.all(
                            width: 1.0,
                            color: Colors.redAccent
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(chatMessage.message,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color:Colors.white,
                            fontSize: 13,
                            decoration: TextDecoration.none
                        ),
                      ),
                    )
                  ),
                )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Align(
              alignment: Alignment.topRight,
              child: Text((chatMessage.ack && chatMessage.to == 'client') ? 'Прочитано' : 'Доставлено',
                style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class QuickMessageScreen extends StatefulWidget {

  TextEditingController messageField;
  QuickMessageScreen({Key key, this.messageField}) : super(key: key);

  @override
  QuickMessageScreenState createState() {
    return new QuickMessageScreenState(messageField: messageField);
  }
}

class QuickMessageScreenState extends State<QuickMessageScreen> {

  TextEditingController messageField;
  QuickMessageScreenState({this.messageField});
  QuickMessageItem quickMessage;
  String quickTextMessage;

  buildQuickMessages(){
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(quickMessage.messages.length, (index){
        return GestureDetector(child:Padding(
            padding: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
            child:Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 2.0, //extend the shadow
                    )
                  ],
                  color: (quickMessage.messages[index] != quickTextMessage) ? Colors.white : Colors.redAccent),
              child:  Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 5,),
                  child: Text(quickMessage.messages[index],
                    style: TextStyle(color: (quickMessage.messages[index] != quickTextMessage) ? Color(0x99999999) : Colors.white, fontSize: 15),)
              ),
            )
        ),onTap: (){
          setState((){
            quickTextMessage = quickMessage.messages[index];
            messageField.text = quickTextMessage;
          });
        },
        );
      }
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if(quickMessage != null){
      return buildQuickMessages();
    }
    return FutureBuilder<QuickMessages>(
      future: Chat.getMessages(),
      builder: (BuildContext context, AsyncSnapshot<QuickMessages> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          quickMessage = snapshot.data.chatMessageList[0];
          return buildQuickMessages();
        }else{
          return Container();
        }
      },
    );
  }
}