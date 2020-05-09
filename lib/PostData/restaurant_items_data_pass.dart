import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<String> _loadRestaurantsItems(){
  return  rootBundle.loadString('https://crm.apis.stage.faem.pro/api/v2/products');
}

Future<RestaurantDataItems> loadRestaurantItems(String uuid) async {
  RestaurantDataItems restaurantDataItems1 = null;
  //String jsonString = await _loadRestaurantsItems();
  //final jsonResponse = json.decode(jsonString);
  print(uuid);
  var url = 'https://crm.apis.stage.faem.pro/api/v2/products';
  var response = await http.post(url, body: jsonEncode({
    "store_uuid": uuid,
    "page": 1,
    "limit": 12
  }), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    restaurantDataItems1 = new RestaurantDataItems.fromJson(jsonResponse);
    restaurantDataItems = restaurantDataItems1;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
//  print('sadsad');
//  print(restaurantDataItems1);
  print('skalfsdalkfhsdfhhfhkhdkhfdshahadafffoof');
  return restaurantDataItems1;
}

//Future loadItems() async{
//    var url = 'https://crm.apis.stage.faem.pro/api/v2/products';
//    var response = await http.post(url, body: {
//      'store_uuid': 'e93ef119-001c-4b27-915a-c86d58790cbf',
//      'page': '1',
//      'limit': '12'
//    });
//    if (response.statusCode == 200) {
//      var jsonResponse = convert.jsonDecode(response.body);
//      RestaurantDataItems restaurantDataItems1 = new RestaurantDataItems.fromJson(jsonResponse);
//      restaurantDataItems = restaurantDataItems1;
//    } else {
//      print('Request failed with status: ${response.statusCode}.');
//    }
//    print('Response body: ${response.body}');
//}