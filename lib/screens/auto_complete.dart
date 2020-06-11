import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/PostData/necessary_address_data_pass.dart';
import 'package:food_delivery/models/NecessaryAddressModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/UserModel.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            user.street + ', ' + user.house,
            style: TextStyle(fontSize: 16.0),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          width: 15.0,
          height: 50.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Theme(data: new ThemeData(hintColor: Color(0xF2F2F2F2)),
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
                  searchTextField.textField.controller.text = item.street + ',' + item.house;
                });
              },
              itemBuilder: (context, item) {
                // ui for the autocomplete row
                return row(item);
              },
            ),
          ),
        ),
      ],
    );
  }
}