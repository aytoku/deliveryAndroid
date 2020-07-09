import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:url_launcher/url_launcher.dart';
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
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:intl/intl.dart';

class AboutAppScreen extends StatefulWidget {

  @override
  AboutAppScreenState createState() => AboutAppScreenState();
}

class AboutAppScreenState extends State<AboutAppScreen>{

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
            Padding(
              padding: EdgeInsets.only(top:25, bottom: 25),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      child: Container(
                          height: 40,
                          width: 40,
                          child: Padding(
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                          )
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Flexible(
                    flex: 8,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text("О приложении", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF3F3F3F)),),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child:  SvgPicture.asset('assets/svg_images/faem_icon.svg'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Center(
                child: Text(
                  'Версия 4.95 от 25 авг. 2019 г.\nсборка 34234',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0x97979797),
                      fontSize: 15
                  ),
                ),
              ),
            ),
            Container(
              height: 30,
              color: Color(0xF3F3F3F3),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 15),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Лицензионное соглашение'),
                        GestureDetector(
                          child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                        )
                      ],
                    ),
                    onTap: () async {
                      if(await Internet.checkConnection()){
                        if (await canLaunch("https://faem.ru/legal/agreement")) {
                          await launch("https://faem.ru/legal/agreement");
                        }
                      }else{
                        noConnection(context);
                      }
                    },
                  ),
              ),
            ),
            Divider(height: 1.0, color: Colors.grey),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 15, bottom: 20, right: 15),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Политика конфиденцальности'),
                        GestureDetector(
                          child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                        )
                      ],
                    ),
                    onTap: () async {
                      if(await Internet.checkConnection()){
                        if (await canLaunch("https://faem.ru/privacy")) {
                          await launch("https://faem.ru/privacy");
                        }
                      }else{
                        noConnection(context);
                      }
                    },
                  ),
              ),
            ),
            Divider(height: 1.0, color: Colors.grey),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: Text(
                  'Таким образом новая модель организационной\nдеятельности представляет собой интересный\nэксперимент проверки. \n@ 2011-2019 ООО «Faem.Taxi»',
                  style: TextStyle(
                      color: Color(0x97979797),
                      fontSize: 15
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}