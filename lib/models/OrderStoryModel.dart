import 'dart:collection';

import 'package:food_delivery/models/ResponseData.dart';

class OrdersStoryModel{
  List<OrdersStoryModelItem> ordersStoryModelItems;

  OrdersStoryModel( {
    this.ordersStoryModelItems,
  });

  factory OrdersStoryModel.fromJson(List<dynamic> parsedJson){

    var records_list = parsedJson;
    print(records_list.runtimeType);
    List<OrdersStoryModelItem> recordList = null;
    if(records_list != null){
      recordList = records_list.map((i) =>
          OrdersStoryModelItem.fromJson(i)).toList();
    }

    return OrdersStoryModel(
        ordersStoryModelItems:recordList,
    );
  }
}

class OrdersStoryModelItem{
  String uuid;
  String comment;
  List<DestinationPoints> routes;
  Records store;
  List<FoodRecordsStory>products;
  int created_at_unix;
  int price;

  OrdersStoryModelItem( {
    this.uuid,
    this.comment,
    this.routes,
    this.store,
    this.products,
    this.created_at_unix,
    this.price
  });

  factory OrdersStoryModelItem.fromJson(Map<String, dynamic> parsedJson){

    var routes_list = parsedJson['routes'] as List;

    Records store = null;
    List<DestinationPoints> routesList = null;
    List<FoodRecordsStory> productsList = null;
    if(routes_list != null){
      routesList = routes_list.map((i) =>
          DestinationPoints.fromJson(i)).toList();
    }
    if(parsedJson['products_data'] != null){
      store  = Records.fromJson(parsedJson['products_data']['store']);
      var products_list = parsedJson['products_data']['products'] as List;
      if(products_list != null){
        productsList = products_list.map((i) =>
            FoodRecordsStory.fromJson(i)).toList();
      }
    }

    return OrdersStoryModelItem(
      uuid: parsedJson['uuid'],
      comment: parsedJson['comment'],
      routes: routesList,
      store: store,
      products: productsList,
      created_at_unix: parsedJson['created_at_unix'],
      price: parsedJson['tariff']['total_price']
    );
  }
}

class FoodRecordsStory{
  String uuid;
  int weight;
  String name;
  String comment;
  bool available;
  int price;
  String image;
  String store_uuid;
  List<Toppings>toppings;
  int number;
  List<Variants>variants;

  FoodRecordsStory( {
    this.uuid,
    this.weight,
    this.name,
    this.comment,
    this.available,
    this.price,
    this.image,
    this.store_uuid,
    this.toppings,
    this.number,
    this.variants,
  });

  factory FoodRecordsStory.fromJson(Map<String, dynamic> parsedJson){

    var toppings_list = parsedJson['toppings'] as List;
    List<Toppings> toppingsList = null;
    if(toppings_list != null){
      toppingsList = toppings_list.map((i) =>
          Toppings.fromJson(i)).toList();
    }

    var variants_list = parsedJson['selected_variant'][0] as List;
    List<Variants> variantsList = null;
    if(variants_list != null){
      variantsList = variants_list.map((i) =>
          Variants.fromJson(i)).toList();
    }

    return FoodRecordsStory(
      uuid: parsedJson['uuid'],
      weight: parsedJson['weight'],
      name: parsedJson['name'],
      comment: parsedJson['comment'],
      available: parsedJson['available'],
      price: parsedJson['price'],
      image: parsedJson['image'],
      number: parsedJson['number'],
      store_uuid: parsedJson['store_uuid'],
      toppings: toppingsList,
      variants: variantsList,
    );
  }
}

class Toppings{
  String uuid;
  String name;
  int price;
  String comment;

  Toppings( {
    this.uuid,
    this.name,
    this.price,
    this.comment,
  });

  factory Toppings.fromJson(Map<String, dynamic> parsedJson){
    return Toppings(
      uuid:parsedJson['uuid'],
      name:parsedJson['name'],
      price:parsedJson['price'],
      comment:parsedJson['comment'],
    );
  }
}

class Variants{
  String uuid;
  String name;
  bool standard;
  int price;
  String comment;

  Variants( {
    this.uuid,
    this.name,
    this.standard,
    this.price,
    this.comment,
  });

  factory Variants.fromJson(Map<String, dynamic> parsedJson){
    return Variants(
      uuid:parsedJson['uuid'],
      name:parsedJson['name'],
      standard:parsedJson['standard'],
      price:parsedJson['price'],
      comment:parsedJson['comment'],
    );
  }
}