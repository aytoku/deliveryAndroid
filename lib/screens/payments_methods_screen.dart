import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';

class PaymentsMethodsScreen extends StatefulWidget {
  @override
  PaymentsMethodsScreenState createState() => PaymentsMethodsScreenState();
}

class PaymentsMethodsScreenState extends State<PaymentsMethodsScreen>{
  bool status1 = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 50),
                        child: SvgPicture.asset('assets/svg_images/arrow_left.svg')
                    )
                ),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50, right: 15),
                    child: Text(
                        'Изменить',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  )
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 30, left: 20),
              child: Text('Способы оплаты',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                child: ListTile(
                  leading: Image(image: AssetImage('assets/images/visa.png'),),
                  title: Text("Visa8744", style: TextStyle(color: Colors.black),),
                  trailing: Image(image: AssetImage('assets/images/circle.png'),),
                ),
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: ListTile(
                leading: Image(image: AssetImage('assets/images/visa.png'),),
                title: Text("Visa8744", style: TextStyle(color: Colors.black),),
                trailing: Image(image: AssetImage('assets/images/circle.png'),),
              ),
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: ListTile(
                leading: Image(image: AssetImage('assets/images/Apple_Pay.png'),),
                title: Text("Apple Pay", style: TextStyle(color: Colors.black),),
                trailing: Image(image: AssetImage('assets/images/circle.png'),),
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
              padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
              child: ListTile(
                title: Text("Добавить карту", style: TextStyle(color: Colors.black),),
                trailing: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                onTap: (){
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => new AttachCardScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(height: 1.0, color: Colors.grey),
        ],
      ),
    );
  }
}