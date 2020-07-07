import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/TicketModel.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/service_orders_story.dart';

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
              Flexible(
                flex: 1,
                child: GestureDetector(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.only(top:25, bottom: 25),
                          child: Container(
                              height: 40,
                              width: 40,
                              child: Padding(
                                padding: EdgeInsets.only(top: 12, bottom: 12),
                                child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                              )
                          )
                      )
                  ),
                  onTap: (){
                    homeScreenKey = new GlobalKey<HomeScreenState>();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        HomeScreen()), (Route<dynamic> route) => false);
                  },
                ),
              ),
              Flexible(
                flex: 10,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, top: 0),
                    child: Text("Служба поддержки", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF424242)),),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20, bottom: 10),
              child: Text('Ваши вопросы',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFB9B9B9))),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 15),
                      child: Text('Ошибка в заказе', style: TextStyle(fontSize: 17, color: Color(0xFF424242)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 15),
                      child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: ''),),
                    ),
                  );
                },
              )
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 15),
                    child: Text('Ошибка стоимости', style: TextStyle(fontSize: 17,color: Color(0xFF424242)),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, right: 15),
                    child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                  ),
                ],
              ),
              onTap: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: '')),
                  ),
                );
              },
            )
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 15),
                      child: Text('Ошибка программмы', style: TextStyle(fontSize: 17, color: Color(0xFF424242)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 15),
                      child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: '')),
                    ),
                  );
                },
              )
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, left: 15),
                      child: Text('Другая причина', style: TextStyle(fontSize: 17, color: Color(0xFF424242)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, right: 15),
                      child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                    ),
                  ],
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: '')),
                    ),
                  );
                },
              )
          ),
          Divider(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}