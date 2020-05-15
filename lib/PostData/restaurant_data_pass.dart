import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<DeliveryResponseData> loadRestaurant(int page, int limit) async {
  DeliveryResponseData deliveryResponseData = null;
  var json_request = jsonEncode({
    "store_uuid": "restaurant",
    "page": page,
    "limit": limit
  });
  var url = 'https://crm.apis.stage.faem.pro/api/v2/stores';
  var response = await http.post(url, body: json_request, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    deliveryResponseData = new DeliveryResponseData.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  return deliveryResponseData;
}