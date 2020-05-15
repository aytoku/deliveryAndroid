import 'package:food_delivery/models/CartDataModel.dart';
import 'package:food_delivery/models/order.dart';

class User{
  final String name;
  final List<Order> orders;
  final CartDataModel cartDataModel;

  User({
    this.name,
    this.orders,
    this.cartDataModel
  });
}