import 'package:flutter/material.dart';
import 'package:food_delivery/screens/address_screen.dart';

class MainScreen extends StatefulWidget {
  //final MainModel model;

  // MainScreen({this.model});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
//  int currentTab = 0;
//
//  // Pages
//  HomePage homePage;
//
//  List<Widget> pages;
//  Widget currentPage;
//
//  @override
//  void initState() {
//    // call the fetch method on food
//    // widget.foodModel.fetchFoods();
//    // widget.model.fetchFoods();
//
//    homePage = HomePage();
//
//    currentPage = homePage;
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) => AddressScreen())
                  );
                },
                leading: Icon(Icons.list),
                title: Text("Add food Item", style: TextStyle(fontSize: 16.0),),
              )
            ],
          ),
        ),
//        resizeToAvoidBottomPadding: false,
//        bottomNavigationBar: BottomNavigationBar(
//          currentIndex: currentTab,
//          onTap: (index) {
//            setState(() {
//              currentTab = index;
//              currentPage = pages[index];
//            });
//          },
//          type: BottomNavigationBarType.fixed,
//          items: <BottomNavigationBarItem>[
//            BottomNavigationBarItem(
//              icon: Icon(
//                Icons.home,
//              ),
//              title: Text("Home"),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(
//                Icons.explore,
//              ),
//              title: Text("Explore"),
//            ),
//          ],
//        ),
        //body: currentPage,
      ),
    );
  }
}
