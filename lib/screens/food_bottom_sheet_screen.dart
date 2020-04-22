//import 'package:flutter/material.dart';
//import 'package:food_delivery/models/global_state.dart';
//
//class ModalTrigger extends StatefulWidget {
//
//  @override
//  ModalTriggerPage createState() => ModalTriggerPage();
//}
//
//class ModalTriggerPage extends State<ModalTrigger>{
//  String apple_pay = "Apple Pay";
//  GlobalState _store = GlobalState.instance;
//
//  @override
//  void initStateModal(){
//    apple_pay = new TextEditingController() as String;
//    _store.set('name', '');
//    apple_pay = _store.get('name');
//  }
//
//  onClickBtn(){
//    _store.set('name', apple_pay);
//    Navigator.of(context).pushNamed('/Create');
//  }
//  _showModalBottomSheet(context) {
//    showModalBottomSheet(
//      context: context,
//      builder: (BuildContext context) {
//        return Container(
//          height: 150,
//          decoration: BoxDecoration(
//            color: Colors.white,
//            borderRadius: BorderRadius.only(
//              topLeft: Radius.circular(20),
//              topRight: Radius.circular(20),
//            ),
//          ),
//          child:  Align(
//            child: Padding(
//              padding: EdgeInsets.only(right: 0),
//              child: Column(
//                children: <Widget>[
//                  new FlatButton(
//                    child: Row(
//                      children: <Widget>[
//                        Image(image: AssetImage('assets/dollar.png'),),
//                        Padding(
//                          padding: EdgeInsets.only(right: 0, left: 15),
//                          child: Text("Наличными", style: TextStyle(color: Colors.black),),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(left: 160),
//                          child:
//                          Image(image: AssetImage('assets/check_box.png'),),
//                        ),
//                      ],
//                    ),
//                    onPressed: () {
//                    },
//                  ),
//                  new FlatButton(
//                    child: Row(
//                      children: <Widget>[
//                        Image(image: AssetImage('assets/play.png'),),
//                        Padding(
//                          padding: EdgeInsets.only(right: 0, left: 15),
//                          child: Text(apple_pay, style: TextStyle(color: Colors.black),),
//                        ),
//                        Padding(
//                          padding: EdgeInsets.only(left: 180),
//                          child:
//                          Image(image: AssetImage('assets/check_box.png'),),
//                        ),
//                      ],
//                    ),
//                    onPressed: onClickBtn,
//                  ),
//                  new FlatButton(
//                    child: Row(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(right: 90),
//                          child: Text("Другой картой", style: TextStyle(color: Colors.black),),
//                        ),
//                      ],
//                    ),
//                    onPressed: () {
//                    },
//                  ),
//                ],
//              ),
//            ),
//          ),
//        );
//      },
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return FlatButton(
//      child: Text('Способы оплаты', style: TextStyle(color: Colors.grey, fontSize: 15),),
//      onPressed: (){
//        _showModalBottomSheet(context);
//      },
//    );
//  }
//}