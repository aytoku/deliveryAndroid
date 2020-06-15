import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/address_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/partners_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:intl/intl.dart';

class BlackListScreen extends StatefulWidget {

  @override
  BlackListScreenState createState() => BlackListScreenState();
}

class BlackListScreenState extends State<BlackListScreen>{
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 30, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                            padding: EdgeInsets.only(),
                            child: Container(
                                width: 20,
                                height: 20,
                                child: Center(
                                  child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                                )
                            )
                        )
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Text("Партнер 1", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                    ),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Text("Готово", style: TextStyle(fontSize: 17),),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new PartnersScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
            Container(
                height: 200,
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return ListTile(
                      title: Text('Партнер 1'),
                      leading: position == selectedIndex ? SvgPicture.asset('assets/svg_images/selected_circle.svg') : SvgPicture.asset('assets/svg_images/circle.svg'),
                      onTap: (){
                        setState(() {
                          selectedIndex = position;
                        });
                      },
                    );
                  },
                )
            )
          ],
        )
    );
  }
}