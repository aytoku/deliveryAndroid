import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/models/my_addresses_model.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/add_my_address_screen.dart';

import 'auto_complete.dart';

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
          padding: EdgeInsets.only(bottom: 20,right: 15),
          child: AutoComplete(destinationPointsKey),
        ),
        Padding(
          padding: EdgeInsets.only(left: 30, top: 350),
          child: FlatButton(
            child: Text("Далее", style: TextStyle(color: Colors.white, fontSize: 15),),
            color: Colors.redAccent,
            splashColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 20),
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
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder<List<MyAddressesModel>>(
        future: MyAddressesModel.getAddresses(),
        builder: (BuildContext context, AsyncSnapshot<List<MyAddressesModel>> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            myAddressesModelList = snapshot.data;
            return Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, top: 50),
                            child: SvgPicture.asset('assets/svg_images/arrow_left.svg'),
                          )
                      ),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                    GestureDetector(
                      child: Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 15, top: 50),
                            child: SvgPicture.asset('assets/svg_images/plus.svg'),
                          )
                      ),
                      onTap: (){
                        MyAddressesModel myAddressModel = new MyAddressesModel(type: MyAddressesType.empty);
                        MyAddressesModel.saveData(myAddressModel).then((value) => setState(() {

                        }));
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20, left: 30, bottom: 20),
                    child: Text('Мои адреса',style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
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
                                                    child: Text('Добавить адрес дома'),
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
                      return GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
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