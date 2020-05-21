import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/screens/auth_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';

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
}