import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/PostData/owners.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/models/OwnersModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/RestaurantDataItems.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/address_screen.dart';
import 'package:food_delivery/screens/black_list_scrren.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/partner_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:intl/intl.dart';

class PartnersScreen extends StatefulWidget {


  @override
  PartnersScreenState createState() => PartnersScreenState();
}

class PartnersScreenState extends State<PartnersScreen>{
  Owners owners;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: FutureBuilder<Owners>(
          future: getOwners(),
          builder: (BuildContext context, AsyncSnapshot<Owners>snapshot){
            if(snapshot.connectionState == ConnectionState.done){
              owners = snapshot.data;
              return Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 30, left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: GestureDetector(
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
                        ),
                        Flexible(
                          flex: 10,
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.only(left: 0),
                              child: Text("Партнеры", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold ),),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: List.generate(owners.ownersModelList.length, (index){
                        return GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                      owners.ownersModelList[index].name
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15, top: 10, bottom: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
                                ),
                              )
                            ],
                          ),
                          onTap: (){
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new PartnerScreen(owner: owners.ownersModelList[index]),
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
                child: CircularProgressIndicator(),
              );
            }
          },
        )
    );
  }
}