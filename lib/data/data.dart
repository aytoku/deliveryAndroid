import 'package:food_delivery/models/CartDataModel.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/addCardScreen.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/user.dart';

RestaurantDataItems restaurantDataItems = null;
AuthCodeData authCodeData = null;
AuthData authData = null;
String device_id = 'ffewqewe';
int code = 0;

final addCart = AddCart(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Sandwich Street',);

// User
final currentUser = User(
  cartDataModel: new CartDataModel(),
  name: 'Harmonie',
  orders: [
  ],
);