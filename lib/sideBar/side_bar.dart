import 'package:flutter/material.dart';
import 'package:food_delivery/config/config.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/screens/auth_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/orders_story_screen.dart';
import 'package:food_delivery/screens/ssettings_screen.dart';

class SideBar extends StatefulWidget{
  @override
  SideBarState createState()=>SideBarState();
}

class SideBarState extends State<SideBar>{
  final GlobalKey<ScaffoldState>_scaffoldKey = new GlobalKey<ScaffoldState>();
  int index = 0;
  List<Widget> list = [
    HomeScreen(),
    OrdersStoryScreen(),
    SettingsScreen(),
    AuthScreen()
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: list[index],
//      Container(
//        child: Padding(
//          padding: EdgeInsets.only(top: 30, left: 15),
//          child: Column(
//            children: <Widget>[
//              Row(
//                children: <Widget>[
//                  GestureDetector(
//                    child: Image(
//                      image: AssetImage(
//                          'assets/images/menu.png'
//                      ),
//                    ),
//                    onTap: (){
//                      _scaffoldKey.currentState.openDrawer();
//                    },
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(left: 30, right: 40),
//                    child: GestureDetector(
//                        child: Text(
//                          'Указать адрес доставки',
//                          style: TextStyle(
//                              color: Colors.redAccent,
//                              fontSize: 14
//                          ),
//                        )
//                    ),
//                  ),
//                  Padding(
//                    padding: EdgeInsets.only(right: 0),
//                    child: GestureDetector(
//                      child: Image(
//                        image: AssetImage(
//                            'assets/images/search.png'
//                        ),
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ],
//          ),
//        )
//      ),
      drawer: MyDrawer(onTap: (ctx,i){
        setState(() {
          index = i;
          Navigator.pop(ctx);
        });
      },)
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
                  title: Text('Способы оплаты'),
                  onTap: ()=>onTap(context, 0),
                ),
                ListTile(
                  title: Text('История заказов'),
                  onTap: ()=>onTap(context, 1),
                ),
                ListTile(
                  title: Text('Мои адреса'),
                  onTap: ()=>onTap(context, 1),
                ),
                ListTile(
                  title: Text('Настройки'),
                  onTap: ()=>onTap(context, 2),
                ),
                ListTile(
                  title: Text('Инфоромация'),
                  onTap: ()=>onTap(context, 2),
                ),
                ListTile(
                  title: Text('Служба поддержки'),
                  onTap: ()=>onTap(context, 2),
                ),
                ListTile(
                  title: Text('Выход'),
                  onTap: (){
                    NecessaryDataForAuth.clear().then((value){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new AuthScreen(),
                        ),
                      );
                    });
                  },
                ),
              ],
            ),
          )
        ),
    );
  }
}