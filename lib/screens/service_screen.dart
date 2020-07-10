import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/Internet/check_internet.dart';
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

  noConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          ),
        );
      },
    );
  }

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
                child: InkWell(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.only(top:25, bottom: 25),
                          child: Container(
                              height: 40,
                              width: 60,
                              child: Padding(
                                padding: EdgeInsets.only(top: 12, bottom: 12, right: 10),
                                child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                              )
                          )
                      )
                  ),
                  onTap: () async {
                    if(await Internet.checkConnection()){
                      homeScreenKey = new GlobalKey<HomeScreenState>();
                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          HomeScreen()), (Route<dynamic> route) => false);
                    }else{
                      noConnection(context);
                    }
                  },
                ),
              ),
              Flexible(
                flex: 6,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20, top: 0),
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
              padding: EdgeInsets.only(),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 15,left: 15),
                      child: Text('Ошибка в заказе', style: TextStyle(fontSize: 17, color: Color(0xFF424242)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 15,right: 15),
                      child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                    ),
                  ],
                ),
                onTap: () async {
                  if(await Internet.checkConnection()){
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: ''),),
                      ),
                    );
                  }else{
                    noConnection(context);
                  }
                },
              )
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
            padding: EdgeInsets.only(),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 15,left: 15),
                    child: Text('Ошибка стоимости', style: TextStyle(fontSize: 17,color: Color(0xFF424242)),),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15, top: 15,right: 15),
                    child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                  ),
                ],
              ),
              onTap: () async {
                if(await Internet.checkConnection()){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: '')),
                    ),
                  );
                }else{
                  noConnection(context);
                }
              },
            )
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
              padding: EdgeInsets.only(),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 15,left: 15),
                      child: Text('Ошибка программмы', style: TextStyle(fontSize: 17, color: Color(0xFF424242)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 15,right: 15),
                      child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                    ),
                  ],
                ),
                onTap: () async {
                  if(await Internet.checkConnection()){
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: '')),
                      ),
                    );
                  }else{
                    noConnection(context);
                  }
                },
              )
          ),
          Divider(height: 1.0, color: Colors.grey),
          Padding(
              padding: EdgeInsets.only(),
              child: InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 15,left: 15),
                      child: Text('Другая причина', style: TextStyle(fontSize: 17, color: Color(0xFF424242)),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15, top: 15,right: 15),
                      child:  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                    ),
                  ],
                ),
                onTap: () async {
                  if(await Internet.checkConnection()){
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new ServiceOrdersStoryScreen(ticketModel: new TicketModel(title: 'Ошибка в заказе', description: '')),
                      ),
                    );
                  }else{
                    noConnection(context);
                  }
                },
              )
          ),
          Divider(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}