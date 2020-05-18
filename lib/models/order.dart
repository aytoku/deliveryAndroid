import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/models/user.dart';

class Order {
  List<User> foodItems = [];
  final Records restaurant;
  final FoodRecords food;
  int quantity;
  final String date;

  Order({
    this.restaurant,
    this.food,
    this.date,
    this.quantity,
  });

  void removeFromList(Order currentFoodItem) {
    if (currentFoodItem.quantity > 1) {
      //only decrease the quantity
      decreaseItemQuantity(currentFoodItem);
    } else {
      //remove it from the list
      foodItems.remove(currentFoodItem);
    }
    //return foodItems;
  }

  void increaseItemQuantity(Order foodItem) => foodItem.incrementQuantity();
  void decreaseItemQuantity(Order foodItem) => foodItem.decrementQuantity();

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}