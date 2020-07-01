import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/PostData/necessary_address_data_pass.dart';
import 'package:food_delivery/models/NecessaryAddressModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/UserModel.dart';
import 'package:food_delivery/models/my_addresses_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutoComplete extends StatefulWidget {
  AutoComplete(Key key) : super(key: key);

  @override
  AutoCompleteDemoState createState() => AutoCompleteDemoState();
}

class AutoCompleteDemoState extends State<AutoComplete> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<DestinationPoints>> key = new GlobalKey();
  static List<DestinationPoints> necessaryAddressDataItems = new List<DestinationPoints>();
  bool loading = true;

  void getUsers(String name) async {
    try {
      necessaryAddressDataItems = (await loadNecessaryAddressData(name)).destinationPoints;
      print(necessaryAddressDataItems[0].unrestricted_value);
      if(loading){
        setState(() {
          loading = false;
        });
      }if(key.currentState != null){
        key.currentState.suggestions = necessaryAddressDataItems;
        key.currentState.setState(() { });
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  @override
  void initState() {
    getUsers('');
    super.initState();
  }

  Widget row(DestinationPoints user) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Text(
              user.street + ', ' + user.house,
              style: TextStyle(fontSize: 16.0, decoration: TextDecoration.none),
              textAlign: TextAlign.start,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MyAddressesModel myAddressesModel;
    List<MyAddressesModel> myAddressesModelList;
//    if(searchTextField.textField.controller.text == 0){
//      return Container(
//        child: ListView(
//          children: List.generate(myAddressesModelList.length, (index){
//            if(myAddressesModelList[index].type == MyAddressesType.empty){
//              return Padding(
//                padding: EdgeInsets.only(left: 30),
//                child: Column(
//                  children: <Widget>[
//                    Align(
//                      alignment: Alignment.centerLeft,
//                      child: Padding(
//                        padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//                        child: Text(myAddressesModelList[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
//                      ),
//                    ),
//                    Align(
//                      alignment: Alignment.centerLeft,
//                      child: GestureDetector(
//                        child: Padding(
//                          padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//                          child: Text(myAddressesModelList[index].address),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              );
//            }
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          }),
//        ),
//      );
//    }
    return Container(
      height: 30,
      child: Theme(data: new ThemeData(hintColor: Color(0xF2F2F2F2)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 0, top: 10),
          child:
          searchTextField = AutoCompleteTextField<DestinationPoints>(
            key: key,
            clearOnSubmit: false,
            suggestions: necessaryAddressDataItems,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            textChanged: (String value){
              if(value.length > 0){
                getUsers(value);
              }
            },
            itemFilter: (item, query){
              return item.street
                  .toLowerCase()
                  .contains(query.toLowerCase());
            },
            itemSorter: (a, b) {
              return a.street.compareTo(b.street);
            },
            itemSubmitted: (item) {
              setState(() {
                searchTextField.textField.controller.text = item.street + ', ' + item.house;
              });
            },
            itemBuilder: (context, item) {
              // ui for the autocomplete row
              return row(item);
            },
          ),
        ),
      ),
    );
  }
}