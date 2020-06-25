import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/SettingsModel.dart';

import 'home_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen>{
  bool status1 = false;
  SettingsModel settingsModel;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder<SettingsModel>(
        future: SettingsModel.getSettings(),
        builder: (BuildContext context, AsyncSnapshot<SettingsModel> snapshot ){
          if(snapshot.connectionState == ConnectionState.done){
            settingsModel = snapshot.data;
            return Column(
              children: <Widget>[
                GestureDetector(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 50),
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
                    homeScreenKey = new GlobalKey<HomeScreenState>();
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                        HomeScreen()), (Route<dynamic> route) => false);
                  },
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, left: 30),
                    child: Text('Настройки',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Text('Не звонить',style: TextStyle(fontSize: 17)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: FlutterSwitch(
                              width: 55.0,
                              height: 25.0,
                              inactiveColor: Color(0xD6D6D6D6),
                              activeColor: Colors.red,
                              valueFontSize: 12.0,
                              toggleSize: 18.0,
                              value: settingsModel.no_call,
                              onToggle: (val) async{
                                settingsModel.no_call = val;
                                await SettingsModel.saveData();
                              },
                            ),
                          )
                        ],
                      )
                  ),
                ),
                Divider(height: 1.0, color: Colors.grey),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 30, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: Text('Не предлагать сообщения о\nснижении цены',style: TextStyle(fontSize: 17)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: FlutterSwitch(
                              width: 55.0,
                              height: 25.0,
                              inactiveColor: Color(0xD6D6D6D6),
                              activeColor: Colors.red,
                              valueFontSize: 12.0,
                              toggleSize: 18.0,
                              value: settingsModel.no_offer,
                              onToggle: (val) async {
                                settingsModel.no_offer = val;
                                await SettingsModel.saveData();
                              },
                            ),
                          )
                        ],
                      )
                  ),
                ),
                Divider(height: 1.0, color: Colors.grey),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: EdgeInsets.only(top: 20, left: 30, bottom: 20, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text('Язык голосового ввода', style: TextStyle(fontSize: 17),),
                              Padding(
                                padding: EdgeInsets.only(top: 5, right: 130),
                                child: Text('Русский', style: TextStyle(fontSize: 13, color: Color(0xC6C6C6C6)),),
                              )
                            ],
                          ),
                          GestureDetector(
                            child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                          )
                        ],
                      )
                  ),
                ),
                Divider(height: 1.0, color: Colors.grey),
              ],
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}