import 'package:flutter/material.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:food_delivery/screens/auth_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
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
        home: AuthScreen(),
        // home: AddFoodItem(),
      ),
    );
  }
}
