import 'dart:convert';
import 'package:food_delivery/models/order_redister.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

class  FoodModel extends Model {
  List<OrderRegister> _foods = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<OrderRegister> get foods {
    return List.from(_foods);
  }

  Future<bool> addFood(OrderRegister food) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> foodData = {
        "address": food.address,
        "office": food.office,
        "floor":food.floor,
        "comment": food.comment,
      };
      final http.Response response = await http.post(
          "https://food-cb2e1.firebaseio.com/foods.json",
          body: json.encode(foodData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      OrderRegister foodWithID = OrderRegister(
        id: responeData["name"],
        address: food.address,
        office: food.office,
        floor: food.floor,
        comment: food.comment,
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

  Future<bool> fetchFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("https://food-cb2e1.firebaseio.com/foods.json");

      // print("Fecthing data: ${response.body}");
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<OrderRegister> foodItems = [];

      fetchedData.forEach((String id, dynamic foodData) {
        OrderRegister foodItem = OrderRegister(
          id: id,
          address: foodData["address"],
          office: foodData["office"],
          floor: foodData["floor"],
          comment: foodData["comment"],
        );

        foodItems.add(foodItem);
      });

      _foods = foodItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }
}
