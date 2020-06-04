import 'package:food_delivery/models/CartDataModel.dart';
import 'package:food_delivery/models/order.dart';

class User{
  String name;
  final List<Order> orders;
  final CartDataModel cartDataModel;
  String phone;

  User({
    this.name,
    this.orders,
    this.cartDataModel,
    this.phone
  });
}