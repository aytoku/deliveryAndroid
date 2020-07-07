import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/models/my_addresses_model.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/add_my_address_screen.dart';
import 'package:food_delivery/data/data.dart';
import 'package:latlong/latlong.dart';

import 'auto_complete.dart';
import 'home_screen.dart';

class MyAddressesScreen extends StatefulWidget {
  @override
  MyAddressesScreenState createState() => MyAddressesScreenState();
}

class MyAddressesScreenState extends State<MyAddressesScreen>{
  List<MyAddressesModel> myAddressesModelList;
  GlobalKey<AutoCompleteDemoState> destinationPointsKey = new GlobalKey();


  void _deleteButton(MyAddressesModel myAddressesModel){
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            )
        ),
        context: context,
        builder: (context){
          return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child:  Container(
                child: _buildDeleteBottomNavigationMenu(myAddressesModel),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                    )
                ),
              )
          );
        });
  }

  Column _buildDeleteBottomNavigationMenu(MyAddressesModel myAddressesModel){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 0,right: 15, top: 10),
          child: AutoComplete(destinationPointsKey),
        ),
        Divider(color: Color(0xFFEDEDED), height: 1, thickness: 1,),
//        Row(
//          children: <Widget>[
//            SvgPicture.asset('assets/svg_images/home.svg'),
//            GestureDetector(
//              child: Text('Карта'),
//              onTap: (){
//                Navigator.push(
//                  context,
//                  new MaterialPageRoute(
//                      builder: (context) {
//                        return new MyMap();
//                      }
//                  ),
//                );
//              },
//            )
//          ],
//        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 300),
            child: FlatButton(
              child: Text("Далее", style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),),
              color: Color(0xFFFE534F),
              splashColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.only(left: 100, top: 20, right: 100, bottom: 20),
              onPressed: (){
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) {
                        myAddressesModel.type = MyAddressesType.home;
                        myAddressesModel.address = destinationPointsKey.currentState.searchTextField.textField.controller.text;
                        return new AddMyAddressScreen(myAddressesModel: myAddressesModel);
                      }
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: FutureBuilder<List<MyAddressesModel>>(
        future: MyAddressesModel.getAddresses(),
        builder: (BuildContext context, AsyncSnapshot<List<MyAddressesModel>> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            myAddressesModelList = snapshot.data;
            if(myAddressesModelList.length == 0){
              myAddressesModelList.add(new MyAddressesModel(type: MyAddressesType.empty));
            }
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.only(top:0, bottom: 0),
                                child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 12, bottom: 12),
                                      child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                                    )
                                )
                            )
                        ),
                        onTap: (){
                          homeScreenKey = new GlobalKey<HomeScreenState>();
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              HomeScreen()), (Route<dynamic> route) => false);
                        },
                      ),
                      GestureDetector(
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 15, top: 0),
                              child: SvgPicture.asset('assets/svg_images/plus.svg'),
                            )
                        ),
                        onTap: (){
                          myAddressesModelList.add(new MyAddressesModel(type: MyAddressesType.empty));
                          MyAddressesModel.saveData().then((value) => setState(() {
                          }));
                        },
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                    child: Text('Мои адреса',style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: Color(0xFF424242))),
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: List.generate(myAddressesModelList.length, (index){
                      if(myAddressesModelList[index].type == MyAddressesType.empty){
                        return Column(
                          children: <Widget>[
                            GestureDetector(
                                child: Row(
                                  children: <Widget>[
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                                          child: GestureDetector(
                                              child: Row(
                                                children: <Widget>[
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/plus_icon.png'
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 20),
                                                    child: Text('Добавить адрес дома',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: Color(0xFF424242)
                                                    ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              onTap: (){
                                                _deleteButton(myAddressesModelList[index]);
                                              }
                                          )
                                      ),
                                    ),
                                    Divider(height: 1.0, color: Colors.grey),
                                  ],
                                )
                            ),
                          ],
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                                child: Text(myAddressesModelList[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
                                  child: Text(myAddressesModelList[index].address),
                                ),
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                        builder: (context) {
                                          return new AddMyAddressScreen(myAddressesModel: myAddressesModelList[index],);
                                        }
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                )
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(

              ),
            );
          }
        },
      )
    );
  }
}