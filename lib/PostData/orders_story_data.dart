import 'dart:convert';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


Future<OrdersStoryModel> loadOrdersStoryModel() async {
  await CreateOrder.sendRefreshToken();
  OrdersStoryModel ordersStoryModel = null;
  var url = 'https://client.apis.stage.faem.pro/api/v2/myorders';
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Source':'ios_client_app_1',
    'Authorization':'Bearer ' + authCodeData.token
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    ordersStoryModel = new OrdersStoryModel.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return ordersStoryModel;
}