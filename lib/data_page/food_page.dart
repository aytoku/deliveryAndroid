import 'package:flutter/material.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';


class DataPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    TextEditingController _name;
    return new MaterialApp(
      title: 'Navigation main',
      routes: <String , WidgetBuilder>{
        '/RestaurantScreen': (BuildContext  context) => new RestaurantScreen(),
      },
      home: new RestaurantScreen(),
    );
  }
}