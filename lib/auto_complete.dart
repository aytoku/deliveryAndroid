import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AutoComplete extends StatefulWidget {
  AutoComplete() : super();

  @override
  _AutoCompleteDemoState createState() => _AutoCompleteDemoState();
}

class _AutoCompleteDemoState extends State<AutoComplete> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  static List<User> users = new List<User>();
  bool loading = true;

  void getUsers() async {
    try {
      final response =
      await http.get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        print('Users: ${users.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<User> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Widget row(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            user.name,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        SizedBox(
          width: 15.0,
          height: 40.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 260),
            child: FlatButton(
              child: Image(image: AssetImage('assets/arrow.png'),),
              onPressed: () {

              },
            ),
          ),
          new Theme(data: new ThemeData(hintColor: Color(0xF2F2F2F2)),
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: loading
                  ? CircularProgressIndicator()
                  : searchTextField = AutoCompleteTextField<User>(
                key: key,
                clearOnSubmit: false,
                suggestions: users,
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Color(0xF2F2F2F2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                itemFilter: (item, query) {
                  return item.name
                      .toLowerCase()
                      .startsWith(query.toLowerCase());
                },
                itemSorter: (a, b) {
                  return a.name.compareTo(b.name);
                },
                itemSubmitted: (item) {
                  setState(() {
                    searchTextField.textField.controller.text = item.name;
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
      ),
    );
  }
}