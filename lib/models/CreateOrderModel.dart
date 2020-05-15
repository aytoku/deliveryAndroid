import 'dart:convert';
import 'dart:ffi';

import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/models/CartDataModel.dart';
import 'package:food_delivery/models/order.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class CreateOrder {
  String address;
  String office;
  String floor;
  String comment;
  CartDataModel cartDataModel;

  CreateOrder( {
    this.address,
    this.office,
    this.floor,
    this.comment,
    this.cartDataModel
  });

  sendRefreshToken() async{
    var url = 'https://client.apis.stage.faem.pro/api/v2/auth/refresh';
    var response = await http.post(url, body: jsonEncode({"refresh": authCodeData.refresh_token}),
        headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      authCodeData = AuthCodeData.fromJson(jsonResponse);
      //print(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print(response.body);
  }

  Future sendData() async {
    await sendRefreshToken();
    print(authCodeData.token);
    var url = 'https://client.apis.stage.faem.pro/api/v2/orders';
    var response = await http.post(url, body: jsonEncode({
      "callback_phone": phone,
      "increased_fare": 25,
      "comment": "Просит побыстрей",
      "products_input": cartDataModel.toJson(),
      "routes": [
        {
          "unrestricted_value": "Наш супермаркет Х.Мамсурова, Мамсурова Хаджи 42",
          "value": "Наш супермаркет Х.Мамсурова",
          "country": "",
          "region": "",
          "region_type": "",
          "city": "Владикавказ",
          "city_type": "",
          "street": "Хаджи Мамсурова",
          "street_type": "",
          "street_with_type": "",
          "house": "42",
          "out_of_town": false,
          "house_type": "",
          "accuracy_level": 0,
          "radius": 10000,
          "comment": "к ржавой калитке",
          "lat": 43.036274,
          "lon": 44.655212
        },
        {
          "unrestricted_value": "Привоз , Академика Шегрена 40",
          "value": "Привоз ",
          "country": "",
          "region": "",
          "region_type": "",
          "city": "Владикавказ",
          "city_type": "",
          "street": "Академика Шегрена",
          "street_type": "",
          "street_with_type": "",
          "house": "40",
          "out_of_town": false,
          "house_type": "",
          "accuracy_level": 0,
          "comment": "к ржавой калитке",
          "radius": 10000,
          "lat": 43.033966,
          "lon": 44.6944
        }
      ],
      "service_uuid": "6b73e9e3-927b-453c-81c4-dfae818291f4",
    }), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Source':'ios_client_app_1',
      'Authorization':'Bearer ' + authCodeData.token
    });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

      http.Response suka = await http.get('https://client.apis.stage.faem.pro/api/v2/orders/' + jsonResponse['uuid'],
         headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Source':'ios_client_app_1',
        'Authorization':'Bearer ' + authCodeData.token
      });
      print(suka.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print(response.body);
  }
}