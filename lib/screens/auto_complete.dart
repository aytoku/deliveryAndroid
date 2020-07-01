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
    print('vah');
    try {
      if(name.length > 0){
        necessaryAddressDataItems = (await loadNecessaryAddressData(name)).destinationPoints;
      }else{
        List<MyAddressesModel> temp = await MyAddressesModel.getAddresses();
        necessaryAddressDataItems.clear();
        for(int i = 0; i < temp.length; i++){
          var element = temp[i];
          NecessaryAddressData necessaryAddressData = await loadNecessaryAddressData(element.address);
          if(necessaryAddressData.destinationPoints.length > 0){
            necessaryAddressDataItems.add(necessaryAddressData.destinationPoints[0]);
          }else{
            necessaryAddressDataItems.add(new DestinationPoints(street: element.address, house: ''));
          }
        }
      }
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
      print(e);
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
    return Container(
      height: 30,
      child: Theme(data: new ThemeData(hintColor: Color(0xF2F2F2F2)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 0, top: 10),
          child:
          searchTextField = AutoCompleteTextField<DestinationPoints>(
            key: key,
            clearOnSubmit: false,
            minLength: 0,
            suggestions: necessaryAddressDataItems,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            textChanged: (String value) async {
              await getUsers(value);
              print(value.length);
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
              print('vi zaebali menya ispolzovat postoyanno fagoti');
              return row(item);
            },
          ),
        ),
      ),
    );
  }
}