import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/screens/auth_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class DeviceIdScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NecessaryDataForAuth>(
      future: NecessaryDataForAuth.getData(),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<NecessaryDataForAuth> snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          necessaryDataForAuth = snapshot.data;
          if(necessaryDataForAuth.refresh_token == null){
            return AuthScreen();
          }
          refreshToken(necessaryDataForAuth.refresh_token);
          print(necessaryDataForAuth.refresh_token);
          return HomeScreen();
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Future refreshToken(String refresh_token) async {
    var url = 'https://client.apis.stage.faem.pro/api/v2/auth/refresh';
    var response = await http.post(url, body: jsonEncode({"refresh": refresh_token}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      authCodeData = AuthCodeData.fromJson(jsonResponse);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    print(response.body);
  }
}
