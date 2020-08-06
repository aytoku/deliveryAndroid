import 'dart:convert';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/ServiceModel.dart';
import 'package:food_delivery/models/TicketModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/TicketModel.dart';

Future<TicketsList> getTicketsByFilter(int page, int limit, String clientPhone) async {

  TicketsList serviceModel = null;
  await CreateOrder.sendRefreshToken();
  var url = 'https://crm.apis.stage.faem.pro/api/v2/tickets/filter?page=$page&limit=$limit&clientphone=$clientPhone';
  var response = await http.get(url, headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Source':'ios_client_app_1',
    'Authorization':'Bearer ' + authCodeData.token
  });
  if (response.statusCode == 200) {

    print(response.body);
    var jsonResponse = convert.jsonDecode(response.body);
    serviceModel = TicketsList.fromJson(jsonResponse);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
  print(response.body);
  return serviceModel;
}