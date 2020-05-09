import 'package:flutter/material.dart';
import 'package:food_delivery/app/app.dart';
import 'package:food_delivery/main_screen.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/test/api_test.dart';
import 'package:food_delivery/test/http_to_internet.dart';
import 'package:food_delivery/test/json_parse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:food_delivery/data/data.dart';

import 'test/http_test.dart';

void main() async {

    var url = 'https://crm.apis.stage.faem.pro/api/v2/stores';
    var response = await http.post(url, body: {
        'type': 'restaurant',
        'page': '1',
        'limit': '5'
    });
    //print(response.request);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      DeliveryResponseData deliveryResponseData1 = new DeliveryResponseData.fromJson(jsonResponse);
      deliveryResponseData = deliveryResponseData1;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print('Response body: ${response.body}');


    runApp(new App());
}
