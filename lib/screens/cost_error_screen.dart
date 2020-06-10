import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/PostData/service_data_pass.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/TicketModel.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/address_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:intl/intl.dart';

import 'home_screen.dart';

class CostErrorScreen extends StatefulWidget {
  final TicketModel ticketModel;
  CostErrorScreen({Key key, this.ticketModel}) : super(key: key);

  @override
  CostErrorScreenState createState() => CostErrorScreenState(ticketModel: ticketModel);
}

class CostErrorScreenState extends State<CostErrorScreen>{
  final TicketModel ticketModel;
  CostErrorScreenState({this.ticketModel});
  TextEditingController descField = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    descField.text = ticketModel.description;
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
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
                      padding: EdgeInsets.only(right: 100),
                      child: Text("Ошибка стоимости", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                    ),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15, top: 20),
                child: Text(
                  'Вы можете написать подробный комментарий\nо доставке или сообщить какую-либо\nинформацию о заказе'
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                height: 345,
                width: 320,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(
                        width: 1.0,
                        color: Colors.grey[200]
                    )
                ),
                child: TextField(
                  controller: descField,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 30),
              child: FlatButton(
                child: Text("Отправить", style: TextStyle(color: Colors.white, fontSize: 15),),
                color: Colors.redAccent,
                splashColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: EdgeInsets.only(left: 100, top: 20, right: 100, bottom: 20),
                onPressed: () async {
                  ticketModel.description = descField.text;
                  await loadServiceData(ticketModel);
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new HomeScreen(),
                    ),
                  );
                },
              ),
            )
          ],
        )
    );
  }
}