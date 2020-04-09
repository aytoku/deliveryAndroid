import 'package:food_delivery/models/addCardScreen.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/models/user.dart';


// Food
final _burrito =
Food(imageUrl: 'assets/images/steak.jpg', name: 'Лакшери\nСэндвич', price: 8.99);
final _steak =
Food(imageUrl: 'assets/images/burrito.jpg', name: 'Авокадный\nСэндвич', price: 17.99);

// Restaurants
final _restaurant0 = Restaurant(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Sandwich Street',
  address: '~45 мин.европейская',
  rating: 5,
  menu: [_burrito, _steak],
);

final List<Restaurant> restaurants = [
  _restaurant0
];

final addCart = AddCart(
  imageUrl: 'assets/images/restaurant1.jpg',
  name: 'Sandwich Street',);

// User
final currentUser = User(
  name: 'Harmonie',
  orders: [
    Order(
      date: 'Nov 10, 2019',
      food: _steak,
      restaurant: _restaurant0,
      quantity: 1,)
  ],
  cart: [
    Order(
      date: 'Nov 11, 2019',
      food: _burrito,
      restaurant: _restaurant0,
      quantity: 2,
    ),
  ],
);