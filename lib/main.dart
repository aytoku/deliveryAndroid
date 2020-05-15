import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery/PostData/auth_code_data_pass.dart';
import 'package:food_delivery/PostData/auth_data_pass.dart';
import 'package:food_delivery/app/app.dart';
import 'package:food_delivery/main_screen.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/Auth.dart';
import 'package:food_delivery/models/AuthCode.dart';
import 'package:food_delivery/test/api_test.dart';
import 'package:food_delivery/test/http_to_internet.dart';
import 'package:food_delivery/test/json_parse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:food_delivery/data/data.dart';

import 'test/http_test.dart';

void main() async {

//    String device_id = 'ffewqewe';
//    int code = 7069;
////    //String phone = '+79631770760';
////    //AuthData _loadAuthData = await loadAuthData(device_id, phone);
//    authCodeData = await loadAuthCodeData(device_id, code);
//    print(authCodeData.token);
//    print(authCodeData.refresh_token);

    runApp(new App());
}
