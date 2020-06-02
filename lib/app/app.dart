import 'package:flutter/material.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:food_delivery/screens/address_screen.dart';
import 'package:food_delivery/screens/auth_screen.dart';
import 'package:food_delivery/screens/code_screen.dart';
import 'package:food_delivery/screens/device_id_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/infromation_screen.dart';
import 'package:food_delivery/screens/my_addresses_screen.dart';
import 'package:food_delivery/screens/orders_details.dart';
import 'package:food_delivery/screens/orders_story_screen.dart';
import 'package:food_delivery/screens/payments_methods_screen.dart';
import 'package:food_delivery/screens/ssettings_screen.dart';
import 'package:food_delivery/sideBar/side_bar.dart';
import 'package:food_delivery/test/api_test.dart';
import 'package:scoped_model/scoped_model.dart';

class App extends StatelessWidget {
  final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Food Delivery App",
        theme: ThemeData(primaryColor: Colors.blueAccent),
        home: DeviceIdScreen(),
        // home: AddFoodItem(),
      ),
    );
  }
}
