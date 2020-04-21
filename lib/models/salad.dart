import 'package:food_delivery/models/food.dart';

class Salad {
  final String name;
  final String imageUrl;
  final String address;
  final int rating;
  final List<Food> menu;

  Salad({
    this.imageUrl,
    this.name,
    this.address,
    this.rating,
    this.menu
  });
}