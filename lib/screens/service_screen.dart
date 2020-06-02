import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';

class ServiceScreen extends StatefulWidget {
  @override
  ServiceScreenState createState() => ServiceScreenState();
}

class ServiceScreenState extends State<ServiceScreen>{
  bool status1 = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              GestureDetector(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15, top: 50),
                      child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                    )
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 30),
              child: Text('Служба поддержки',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}