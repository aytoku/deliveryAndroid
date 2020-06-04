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
              Center(
                child: Padding(
                  padding: EdgeInsets.only(left: 100, top: 50),
                  child: Text("Служба поддержки", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                ),
              )
            ],
          ),
//          Align(
//            alignment: Alignment.centerLeft,
//            child: Padding(
//              padding: EdgeInsets.only(top: 30, left: 20, bottom: 10),
//              child: Text('Последняя поездка',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xB9B9B9B9))),
//            ),
//          ),
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//            decoration: BoxDecoration(
//                boxShadow: [
//                  BoxShadow(
//                    color: Colors.black12,
//                    blurRadius: 8.0, // soften the shadow
//                    spreadRadius: 3.0, //extend the shadow
//                  )
//                ],
//                color: Colors.white,
//                borderRadius: BorderRadius.circular(15.0),
//                border: Border.all(
//                    width: 1.0,
//                    color: Colors.grey[200]
//                )
//            ),
//            child: Column(
//              children: <Widget>[
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                  children: <Widget>[
//                    Padding(
//                      padding: EdgeInsets.only(top: 10, left: 15),
//                      child: Text('Сегодня 10:10', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
//                    ),
//                    Padding(
//                      padding: EdgeInsets.only(top: 10, right: 15),
//                      child: Text('Сегодня 10:10', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
//                    ),
//                  ],
//                ),
//                Align(
//                  alignment: Alignment.centerLeft,
//                  child: Padding(
//                    padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
//                    child: Text('Максима Горького, 23', style: TextStyle(fontSize: 17),),
//                  ),
//                )
//              ],
//            ),
//          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20, bottom: 10),
              child: Text('Ваши вопросы',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xB9B9B9B9))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Text('Ошибка в заказе', style: TextStyle(fontSize: 17),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 15),
                  child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Text('Ошибка стоимости', style: TextStyle(fontSize: 17),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 15),
                  child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Text('Ошибка программмы', style: TextStyle(fontSize: 17),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 15),
                  child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Text('Другая поездка', style: TextStyle(fontSize: 17),),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 15),
                  child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                ),
              ],
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}