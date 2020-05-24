import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/orders_story_screen.dart';
import 'package:food_delivery/screens/ssettings_screen.dart';

class SideBar extends StatefulWidget{
  @override
  SideBarState createState()=>SideBarState();
}

class SideBarState extends State<SideBar>{
  int index = 0;
  List<Widget> list = [
    HomeScreen(),
    OrdersStoryScreen(),
    SettingsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: list[index],
      drawer: MyDrawer(onTap: (ctx,i){
        setState(() {
          index = i;
          Navigator.pop(ctx);
        });
      },),
    );
  }
}

class MyDrawer extends StatelessWidget{

  final Function onTap;

  MyDrawer({
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
        width: MediaQuery.of(context).size.width*0.8,
        child: Drawer(
          child: Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(necessaryDataForAuth.phone_number, style: TextStyle(color: Colors.black),),
                ),
                ListTile(
                  title: Text('Рестораны'),
                  onTap: ()=>onTap(context, 0),
                ),
                ListTile(
                  title: Text('История заказов'),
                  onTap: ()=>onTap(context, 1),
                ),
                ListTile(
                  title: Text('Настройки'),
                  onTap: ()=>onTap(context, 2),
                ),
              ],
            ),
          )
        ),
    );
  }
}