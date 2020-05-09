import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/addCardScreen.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_list.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/models/user.dart';

DeliveryResponseData deliveryResponseData = null;
RestaurantDataItems restaurantDataItems = null;
// Food
final _burrito =
Food(imagePath: 'assets/images/steak.jpg', name: 'Лакшери\nСэндвич', price: 90);
final _steak =
Food(imagePath: 'assets/images/burrito.jpg', name: 'Авокадный\nСэндвич', price: 99);


// Restaurants
final _restaurant0 = Restaurant(
  imageUrl: 'https://storage.googleapis.com/faem-ios-images/store_images/maracana_logo.png',
  name: 'Sandwich Street',
  address: '~45 мин.европейская',
  rating: 5,
  menu: [_burrito, _steak],
);
final _restaurant1 = Restaurant(
  imageUrl: 'https://storage.googleapis.com/faem-ios-images/store_images/maracana_logo.png',
  name: 'Sandwich Street',
  address: '~45 мин.европейская',
  rating: 5,
  menu: [_burrito, _steak],
);

final List<Restaurant> restaurants = [
  _restaurant0,
  _restaurant1,
];

final addCart = AddCart(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Sandwich Street',);

// User
final currentUser = User(
  name: 'Harmonie',
  orders: [
  ],
  cart:  [
  ],
);