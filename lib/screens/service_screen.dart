import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/getTicketsByFilter.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/TicketModel.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/archive_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/service_orders_story.dart';
import 'package:food_delivery/screens/tickets_chat_screen.dart';
import 'package:intl/intl.dart';

import '../data/data.dart';
import '../data/data.dart';
import '../models/ServiceModel.dart';
import '../models/TicketModel.dart';

class ServiceScreen extends StatefulWidget {
  @override
  ServiceScreenState createState() => ServiceScreenState();
}

class ServiceScreenState extends State<ServiceScreen> {

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
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
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
        body: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(
                        child: Container(
                            height: 50,
                            width: 60,
                            child: Padding(
                              padding:
                              EdgeInsets.only(top: 17, bottom: 17, right: 10),
                              child: SvgPicture.asset(
                                  'assets/svg_images/arrow_left.svg'),
                            )),
                        onTap: () async {
                          if (await Internet.checkConnection()) {
                            homeScreenKey = new GlobalKey<HomeScreenState>();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false);
                          } else {
                            noConnection(context);
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text(
                            "Служба поддержки",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF424242)),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 16, bottom: 10),
                        child: Text('Ваши вопросы',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB9B9B9))),
                      ),
                    ),
                    Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeBottom: true,
                          child: ListView(
                            padding: EdgeInsets.zero,
                            children: <Widget>[
                              ListTile(
                                leading: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child: Text(
                                    'Ошибка в заказе',
                                    style: TextStyle(fontSize: 17, color: Color(0xFF424242)),
                                  ),
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child:
                                  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                                onTap: () async {
                                  if (await Internet.checkConnection()) {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => new ServiceOrdersStoryScreen(
                                          ticketModel: new TicketModel(
                                              title: 'Ошибка в заказе', description: ''),
                                        ),
                                      ),
                                    );
                                  } else {
                                    noConnection(context);
                                  }
                                },
                              ),
                              Divider(height: 1.0, color: Color(0xFFEDEDED)),
                              ListTile(
                                leading: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child: Text(
                                    'Ошибка стоимости',
                                    style: TextStyle(fontSize: 17, color: Color(0xFF424242)),
                                  ),
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child:
                                  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                                onTap: () async {
                                  if (await Internet.checkConnection()) {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => new ServiceOrdersStoryScreen(
                                            ticketModel: new TicketModel(
                                                title: 'Ошибка стоимости', description: '')),
                                      ),
                                    );
                                  } else {
                                    noConnection(context);
                                  }
                                },
                              ),
                              Divider(height: 1.0, color: Color(0xFFEDEDED)),
                              ListTile(
                                leading: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child: Text(
                                    'Ошибка программмы',
                                    style: TextStyle(fontSize: 17, color: Color(0xFF424242)),
                                  ),
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child:
                                  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                                onTap: () async {
                                  if (await Internet.checkConnection()) {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => new ServiceOrdersStoryScreen(
                                            ticketModel: new TicketModel(
                                                title: 'Ошибка программмы', description: '')),
                                      ),
                                    );
                                  } else {
                                    noConnection(context);
                                  }
                                },
                              ),
                              Divider(height: 1.0, color: Color(0xFFEDEDED)),
                              ListTile(
                                leading: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child: Text(
                                    'Другая причина',
                                    style: TextStyle(fontSize: 17, color: Color(0xFF424242)),
                                  ),
                                ),
                                trailing: Padding(
                                  padding: EdgeInsets.only(bottom: 15, top: 15),
                                  child:
                                  SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                                onTap: () async {
                                  if (await Internet.checkConnection()) {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => new ServiceOrdersStoryScreen(
                                            ticketModel: new TicketModel(
                                                title: 'Другая причина', description: '')),
                                      ),
                                    );
                                  } else {
                                    noConnection(context);
                                  }
                                },
                              ),
                              Divider(height: 1.0, color: Color(0xFFEDEDED)),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, left: 16, bottom: 10),
                        child: Text('Мои обращения',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB9B9B9))),
                      ),
                    ),
                    FutureBuilder<TicketsList>(
                      future:
                      getTicketsByFilter(1, 0, necessaryDataForAuth.phone_number),
                      builder:
                          (BuildContext context, AsyncSnapshot<TicketsList> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null) {
                          return Expanded(
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: List.generate(snapshot.data.recordsCount, (index) {
                                  var format = new DateFormat('yy.MM.dd, HH:mm');
                                  return Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Text(format.format(DateTime.fromMicrosecondsSinceEpoch(snapshot.data.records[index].createdAtUnix * 1000)),
                                          style: TextStyle(
                                              color: Color(0xFF424242),
                                              fontSize: 17
                                          ),
                                        ),
                                        trailing: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                        onTap: () async {
                                          if (await Internet.checkConnection()) {
                                            Navigator.push(
                                                context,
                                                new MaterialPageRoute(
                                                    builder: (context) =>
                                                    new TicketsChatScreen(order_uuid: snapshot.data.records[index].uuid,))
                                            );
                                          } else {
                                            noConnection(context);
                                          }
                                          print('OYAOYA');
                                        },
                                      ),
                                      Divider(height: 1.0, color: Color(0xFFEDEDED)),
                                    ],
                                  );
                                }),
                              ));
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
