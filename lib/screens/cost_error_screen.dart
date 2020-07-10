import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/Internet/check_internet.dart';
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
    descField.text = ticketModel.description;
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:25, bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                              padding: EdgeInsets.only(),
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
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 6,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 30),
                        child: Text("Ошибка стоимости", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF424242)),),
                      ),
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
                  'Вы можете написать подробный комментарий\nо доставке или сообщить какую-либо\nинформацию о заказе',
                  style: TextStyle(
                    color: Color(0xFF424242),
                    fontSize: 14
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15, top: 20),
                    child: Text(
                      '*',
                      style: TextStyle(
                          color: Color(0xFFFC5B58),
                          fontSize: 14
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, top: 20),
                    child: Text(
                      'Комментарий',
                      style: TextStyle(
                          color: Color(0xFFB0B0B0),
                          fontSize: 14
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
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
                  minLines: 1,
                  maxLines: 100,
                  controller: descField,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 14),
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    border: InputBorder.none,
                    counterText: '',
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 0, top: 20, bottom: 10),
              child: FlatButton(
                child: Text("Отправить", style: TextStyle(color: Colors.white, fontSize: 15),),
                color: Color(0xFFFC5B58),
                splashColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                padding: EdgeInsets.only(left: 100, top: 20, right: 100, bottom: 20),
                onPressed: () async {
                  if(await Internet.checkConnection()){
                    ticketModel.description = descField.text;
                    await loadServiceData(ticketModel);
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new HomeScreen(),
                      ),
                    );
                  }else{
                    noConnection(context);
                  }
                },
              ),
            )
          ],
        )
    );
  }
}