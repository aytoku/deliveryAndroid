import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/OwnersModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/address_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:intl/intl.dart';

class PartnerScreen extends StatefulWidget {
  final OwnersModel owner;
  PartnerScreen({Key key, this.owner}) : super(key: key);
  @override
  PartnerScreenState createState() => PartnerScreenState(owner);
}

class PartnerScreenState extends State<PartnerScreen>{
  OwnersModel owner;
  PartnerScreenState(this.owner);
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
                      padding: EdgeInsets.only(right: 130),
                      child: Text(owner.name, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  '№ ' + owner.id.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0x97979797)
                  ),
                ),
              )
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  'ООО “Партнер 1”, 362040, Северная\nОсетия - Алания Респ., г. Владикавказ,\nпросп. Мира, д. 31, ORGN: 111111939',
                  style: TextStyle(
                      fontSize: 17
                  ),
                ),
              )
            )
          ],
        )
    );
  }
}