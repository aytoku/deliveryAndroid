import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/about_app_screen.dart';
import 'package:food_delivery/screens/partners_screen.dart';

class InformationScreen extends StatefulWidget {
  @override
  InformationScreenState createState() => InformationScreenState();
}

class InformationScreenState extends State<InformationScreen>{
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
              padding: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 15),
              child: Text('Информация',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          GestureDetector(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Партнеры'),
                      GestureDetector(
                        child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                      )
                    ],
                  )
              ),
            ),
            onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new PartnersScreen(),
                ),
              );
            },
          ),
          Divider(height: 1.0, color: Colors.grey),
          GestureDetector(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('О приложении'),
                      GestureDetector(
                        child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                      ),
                    ],
                  )
              ),
            ),
            onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (context) => new AboutAppScreen(),
                ),
              );
            },
          ),
          Divider(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}