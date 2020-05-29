import 'dart:convert';

import 'package:device_id/device_id.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NecessaryDataForAuth{
 String device_id;
 String phone_number;
 String refresh_token;

 NecessaryDataForAuth({
   this.device_id,
   this.phone_number,
   this.refresh_token
 });

 static Future<NecessaryDataForAuth> getData() async{
   String device_id = await DeviceId.getID;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String phone_number = prefs.getString('phone_number');
   String refresh_token = prefs.getString('refresh_token');
   NecessaryDataForAuth result = new NecessaryDataForAuth(device_id: device_id, phone_number: phone_number, refresh_token: refresh_token);
   if(!(await refreshToken(refresh_token))){
     result.refresh_token = null;
   }else{
     saveData(phone_number, authCodeData.refresh_token);
   }
   return result;
 }

 static Future<NecessaryDataForAuth> saveData(String phone_number, String refresh_token) async{
   String device_id = await DeviceId.getID;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString('phone_number', phone_number);
   prefs.setString('refresh_token',refresh_token);
   NecessaryDataForAuth result = new NecessaryDataForAuth(device_id: device_id, phone_number: phone_number, refresh_token: refresh_token);
   return result;
 }

 static Future<bool> refreshToken(String refresh_token) async {
   bool result = false;
   var url = 'https://client.apis.stage.faem.pro/api/v2/auth/refresh';
   var response = await http.post(url, body: jsonEncode({"refresh": refresh_token}),
       headers: <String, String>{
         'Content-Type': 'application/json; charset=UTF-8',
       });
   if (response.statusCode == 200) {
     result = true;
     var jsonResponse = convert.jsonDecode(response.body);
     authCodeData = AuthCodeData.fromJson(jsonResponse);
   } else {
     print('Request failed with status: ${response.statusCode}.');
   }
   return result;
 }
}