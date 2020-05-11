import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<String> _loadRestaurantsItems(){
  return  rootBundle.loadString('https://crm.apis.stage.faem.pro/api/v2/products');
}

Future<RestaurantDataItems> loadRestaurantItems(String uuid, String category) async {
  RestaurantDataItems restaurantDataItems1 = null;
  print(uuid);
  var json_request = jsonEncode({
    "store_uuid": uuid,
    "category": category,
    "page": 1,
    "limit": 12
  });
  if(category == ''){
    json_request = jsonEncode({
      "store_uuid": uuid,
      "page": 1,
      "limit": 12
    });
  }
  var url = 'https://crm.apis.stage.faem.pro/api/v2/products';
  var response = await http.post(url, body: json_request, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    restaurantDataItems1 = new RestaurantDataItems.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(restaurantDataItems1);
  return restaurantDataItems1;
}