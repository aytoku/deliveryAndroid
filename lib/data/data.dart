import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/models/CartDataModel.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/addCardScreen.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/user.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:food_delivery/screens/tickets_chat_screen.dart';

Map<String,GlobalKey<OrderCheckingState>> orderCheckingStates = new Map<String,GlobalKey<OrderCheckingState>>();
Map<String,GlobalKey<ChatMessageScreenState>> chatMessagesStates = new Map<String,GlobalKey<ChatMessageScreenState>>();
Map<String,GlobalKey<TicketsChatMessageScreenState>> ticketsChatMessagesStates = new Map<String,GlobalKey<TicketsChatMessageScreenState>>();
GlobalKey<HomeScreenState>homeScreenKey = new GlobalKey<HomeScreenState>(debugLabel: 'homeScreenKey');
var home  = new MaterialPageRoute(
  builder: (context) => new HomeScreen(),
);
RestaurantDataItems restaurantDataItems = null;
GlobalKey<ChatScreenState>chatKey = new GlobalKey<ChatScreenState>();
AuthCodeData authCodeData = null;
AuthData authData = null;
String FCMToken = '';
int code = 0;
NecessaryDataForAuth necessaryDataForAuth = new NecessaryDataForAuth(phone_number: null, refresh_token: null, device_id: null, name: null);

var DeliveryStates = [
  'cooking',
  'offer_offered',
  'smart_distribution',
  'finding_driver',
  'offer_rejected',
  'order_start',
  'on_place',
  'waiting_for_confirmation',
  'on_the_way',
  'order_payment'
];

final addCart = AddCart(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Sandwich Street',);

// User
final currentUser = User(
  cartDataModel: null,
  name: '',
  orders: [
  ],
);