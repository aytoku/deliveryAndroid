import 'dart:convert';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future sendFCMToken(String token) async {

  var json_request = jsonEncode({
    "token": token,
  });
  var url = 'https://client.apis.stage.faem.pro/api/v2/firebasetoken';
  var response = await http.post(url, body: json_request, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    authCodeData = new AuthCodeData.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return authCodeData;
}