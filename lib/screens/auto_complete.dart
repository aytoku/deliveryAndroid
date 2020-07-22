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
  String hint;

  AutoComplete(Key key, this.hint) : super(key: key);

  @override
  AutoCompleteDemoState createState() => AutoCompleteDemoState(hint);
}

class AutoCompleteDemoState extends State<AutoComplete> {
  String hint;

  AutoCompleteDemoState(this.hint);

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<DestinationPoints>> key =
      new GlobalKey();
  static List<DestinationPoints> necessaryAddressDataItems =
      new List<DestinationPoints>();
  bool loading = true;

  void getUsers(String name) async {
    print(name);
    try {
      if (name.length > 0) {
        necessaryAddressDataItems =
            (await loadNecessaryAddressData(name)).destinationPoints;
      } else {
        List<MyAddressesModel> temp = await MyAddressesModel.getAddresses();
        necessaryAddressDataItems = new List<DestinationPoints>();
        for (int i = 0; i < temp.length; i++) {
          var element = temp[i];
          NecessaryAddressData necessaryAddressData =
              await loadNecessaryAddressData(element.address);
          if (necessaryAddressData.destinationPoints.length > 0) {
            necessaryAddressData.destinationPoints[0].comment = temp[i].comment;
            necessaryAddressDataItems
                .add(necessaryAddressData.destinationPoints[0]);
          } else {
            necessaryAddressDataItems.add(new DestinationPoints(
                street: element.address, house: '', comment: temp[i].comment));
          }
        }
      }
      print(necessaryAddressDataItems[0].unrestricted_value);
      print('dick lenght ' + necessaryAddressDataItems.length.toString());
      if (loading) {
        setState(() {
          loading = false;
        });
      }
      if (key.currentState != null) {
        key.currentState.suggestions = necessaryAddressDataItems;
        key.currentState.setState(() {});
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
              user.unrestricted_value,
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
      child: Theme(
        data: new ThemeData(hintColor: Color(0xF2F2F2F2)),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 0, top: 10),
          child: searchTextField = AutoCompleteTextField<DestinationPoints>(
            textCapitalization: TextCapitalization.sentences,
            key: key,
            clearOnSubmit: false,
            minLength: 0,
            suggestions: necessaryAddressDataItems,
            decoration: new InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Color(0xFFD4D4D4), fontSize: 17),
              border: InputBorder.none,
              counterText: '',
            ),
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            textChanged: (String value) async {
              await getUsers(value);
              print(value.length);
            },
            itemFilter: (item, query) {
              return item.unrestricted_value.toLowerCase().contains(query.toLowerCase());
            },
            itemSorter: (a, b) {
              return a.unrestricted_value.compareTo(b.unrestricted_value);
            },
            itemSubmitted: (item) {
              setState(() {
                searchTextField.textField.controller.text =
                    item.unrestricted_value;
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
