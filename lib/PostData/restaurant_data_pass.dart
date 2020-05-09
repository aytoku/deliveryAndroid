import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future<String> _loadRestaurants() async {
  return await rootBundle.loadString('https://crm.apis.stage.faem.pro/api/v2/stores');
}

Future loadRestaurant() async {
  String jsonString= await _loadRestaurants();
  final jsonResponse = json.decode(jsonString);
  var response = await http.post(jsonResponse, body: {
    'type': 'restaurant',
    'page': '1',
    'limit': '12'
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    DeliveryResponseData deliveryResponseData1 = new DeliveryResponseData.fromJson(jsonResponse);
    deliveryResponseData = deliveryResponseData1;
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print('Response body: ${response.body}');
}

//Future loadItems() async{
//  var url = 'https://crm.apis.stage.faem.pro/api/v2/stores';
//  var response = await http.post(url, body: {
//    'type': 'restaurant',
//    'page': '1',
//    'limit': '12'
//  });
//  if (response.statusCode == 200) {
//    var jsonResponse = convert.jsonDecode(response.body);
//    DeliveryResponseData deliveryResponseData1 = new DeliveryResponseData.fromJson(jsonResponse);
//    deliveryResponseData = deliveryResponseData1;
//  } else {
//    print('Request failed with status: ${response.statusCode}.');
//  }
//  print('Response body: ${response.body}');
//}