import 'package:food_delivery/models/food.dart';

class AddCart {
  final String name;
  final String imageUrl;

  AddCart({
    this.imageUrl,
    this.name,
  });

  void forEach(Null Function(AddCart addCart) param0) {}
}