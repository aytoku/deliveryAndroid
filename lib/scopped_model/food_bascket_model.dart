import 'dart:convert';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/order_redister.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class  FoodBasketModel extends Model {
  List<Order> _foods = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Order> get foods {
    return List.from(_foods);
  }

  Future<bool> addFood(Order order) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> foodData = {
        "name": order.food.name,
        "price": order.food.price,
      };
      final http.Response response = await http.post(
          "https://food-cb2e1.firebaseio.com/foods.json",
          body: json.encode(foodData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      Order foodWithID = Order(
        id: responeData["name"],
        food: Food(name: order.food.name, price: order.food.price),
      );

      _foods.add(foodWithID);
      _isLoading = false;
      notifyListeners();
      // fetchFoods();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

//  Future<bool> fetchFoods() async {
//    _isLoading = true;
//    notifyListeners();
//
//    try {
//      final http.Response response =
//      await http.get("https://food-cb2e1.firebaseio.com/foods.json");
//
//      // print("Fecthing data: ${response.body}");
//      final Map<String, dynamic> fetchedData = json.decode(response.body);
//      print(fetchedData);
//
//      final List<Order> foodItems = [];
//
//      fetchedData.forEach((String id, dynamic foodData) {
//        Order foodItem = Order(
//          id: id,
//          name: foodData["name"],
//          price: foodData["price"],
//        );
//
//        foodItems.add(foodItem);
//      });
//
//      _foods = foodItems;
//      _isLoading = false;
//      notifyListeners();
//      return Future.value(true);
//    } catch (error) {
//      _isLoading = false;
//      notifyListeners();
//      return Future.value(false);
//    }
//  }
}
