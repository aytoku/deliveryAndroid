import 'package:food_delivery/models/order.dart';

class CartDataModel {
  List<Order> cart = new List<Order>();

  List<Map<String, dynamic>> toJson(){
    //Map<dynamic, dynamic> result = new Map<dynamic, dynamic>();
    List<Map<String, dynamic>> list = new List<Map<String, dynamic>>();
    cart.forEach((Order order) {
      Map<String, dynamic> item =
          {
            "uuid": order.food.uuid,
            "variat_uuid": null,
            "toppings_uuid": null,
            "number": order.quantity
          };
      list.add(item);
    });
    return list;
  }
}