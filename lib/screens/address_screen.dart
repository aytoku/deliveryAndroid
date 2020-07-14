import 'dart:math';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/necessary_address_data_pass.dart';
import 'package:food_delivery/models/my_addresses_model.dart';
import 'package:food_delivery/screens/auto_complete.dart';
import 'AttachCardScreen.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/CreateOrderModel.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/CreateModelTakeAway.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/food_list.dart';
import 'package:food_delivery/models/global_state.dart';
import 'package:food_delivery/models/modal_trigger.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/models/order_redister.dart';
import 'package:food_delivery/models/restaurant.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:food_delivery/screens/add_card_screen.dart';
import 'package:food_delivery/screens/cart_screen.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/take_away_screen.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:food_delivery/sideBar/side_bar.dart';
import 'package:food_delivery/widgets/rating_starts.dart';
import 'package:scoped_model/scoped_model.dart';

import 'add_my_address_screen.dart';
import 'food_bottom_sheet_screen.dart';

class PageScreen extends StatefulWidget {
  final Records restaurant;

  PageScreen({
    Key key,
    this.restaurant,
  }) : super(key: key);

  @override
  PageState createState() => PageState(restaurant);
}

class PageState extends State<PageScreen> {
  final Records restaurant;

  PageState(this.restaurant);

  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('suka');
    var addressScreen = AddressScreen(restaurant: restaurant, pageState: this);
    var takeAwayScreen = TakeAway(restaurant: restaurant, pageState: this);
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _controller,
      children: [addressScreen, takeAwayScreen],
    );
  }
}

class AddressScreen extends StatefulWidget {
  PageState pageState;
  MyAddressesModel myAddressesModel;

  AddressScreen(
      {Key key, this.restaurant, this.myAddressesModel, this.pageState})
      : super(key: key);
  final Records restaurant;

  @override
  _AddressScreenState createState() =>
      _AddressScreenState(restaurant, myAddressesModel, pageState);
}

class _AddressScreenState extends State<AddressScreen>
    with AutomaticKeepAliveClientMixin {
  String address = 'Адрес доставки';
  String office;
  String floor;
  String comment;
  String delivery;
  final Records restaurant;
  PageState pageState;

  GlobalKey<AutoCompleteDemoState> destinationPointsKey = new GlobalKey();
  bool _color;

  _AddressScreenState(this.restaurant, this.myAddressesModel, this.pageState);

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  bool status1 = false;
  String title = 'Наличными';
  String image = 'assets/svg_images/dollar_bills.svg';
  String checkbox = 'assets/images/checkbox.png';

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  final maxLines = 1;
  TextEditingController commentField = new TextEditingController();
  TextEditingController officeField = new TextEditingController();
  TextEditingController floorField = new TextEditingController();

  String addressName = '';

  List<MyAddressesModel> myAddressesModelList;
  MyAddressesModel myAddressesModel;

  noConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteButton(MyAddressesModel myAddressesModel) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20),
          topRight: const Radius.circular(20),
        )),
        context: context,
        builder: (context) {
          return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Container(
                child: _buildDeleteBottomNavigationMenu(myAddressesModel),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                    )),
              ));
        });
  }

  Column _buildDeleteBottomNavigationMenu(MyAddressesModel myAddressesModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 0, right: 15, top: 10),
          child: AutoComplete(destinationPointsKey, ''),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(left: 30, top: 370),
            child: FlatButton(
              child: Text(
                "Далее",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              color: Color(0xFFFE534F),
              splashColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding:
                  EdgeInsets.only(left: 70, top: 20, right: 70, bottom: 20),
              onPressed: () async {
                if (await Internet.checkConnection()) {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) {
                      myAddressesModel.type = MyAddressesType.home;
                      myAddressesModel.address = destinationPointsKey
                          .currentState
                          .searchTextField
                          .textField
                          .controller
                          .text;
                      return new AddressScreen(
                          myAddressesModel: myAddressesModel);
                    }),
                  );
                } else {
                  noConnection(context);
                }
              },
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach(
        (Order order) => totalPrice += order.quantity * order.food.price);
    return Scaffold(
        key: _scaffoldStateKey,
        resizeToAvoidBottomPadding: false,
        body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 15),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Container(
                                    height: 40,
                                    width: 60,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 12, bottom: 12, right: 20),
                                      child: SvgPicture.asset(
                                          'assets/svg_images/arrow_left.svg'),
                                    ))),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Text(
                            "Оформление заказа",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Divider(
                    color: Color(0xFFF5F5F5),
                    height: 1,
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          child: GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  color: Color(0xFFFE534F),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 10),
                                  child: Text(
                                    'Доставка',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: SizedBox(
                          height: 40,
                          child: GestureDetector(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: 40, right: 40, top: 10),
                                  child: Text(
                                    'Заберу сам',
                                    style: TextStyle(
                                        color: Color(0xFF999999), fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            onTap: () async {
                              if (await Internet.checkConnection()) {
                                pageState._controller.animateToPage(1,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.elasticOut);
//                            {
//                            Navigator.pushReplacement(
//                              context,
//                              new MaterialPageRoute(
//                                builder: (context) => new TakeAway(restaurant: restaurant),
//                              ),
//                            );
//                          }
                                setState(() {
                                  _color = !_color;
                                });
                              } else {
                                noConnection(context);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
//                    Row(
//                      children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(top: 10, left: 15),
//                          child: Text('Адрес доставки',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
//                        ),
//                      ],
//                    ),
                              Padding(
                                padding: EdgeInsets.only(top: 15, left: 15),
                                child: Row(
                                  children: <Widget>[
                                    //_buildTextFormField('Адрес доставки')
                                    Text(
                                      'Адрес доставки',
                                      style: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 11),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  child:
                                      AutoComplete(destinationPointsKey, '')),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Divider(
                                    height: 1.0, color: Color(0xFFEDEDED)),
                              ),
//                      Padding(
//                        padding: EdgeInsets.only(top: 0),
//                        child: GestureDetector(
//                          child: Column(
//                            children: <Widget>[
//                              Text('sdfs', textAlign: TextAlign.start,),
//                              Divider(height: 1, color: Color(0xFFF5F5F5),thickness: 2,)
//                            ],
//                          ),
//                          onTap: (){
//                            _deleteButton(myAddressesModel);
//                          },
//                        ),
//                      ),
//                      Padding(
//                        padding: EdgeInsets.only(left: 15, bottom: 20),
//                        child: _buildTextFormField("Подъезд"),
//                      ),Padding(
//                        padding: EdgeInsets.only(left: 15, bottom: 20),
//                        child: _buildTextFormField("Кв./офис"),
//                      ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, bottom: 5, right: 85),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Подъезд',
                                      style: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 13),
                                    ),
                                    Text(
                                      'Этаж',
                                      style: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 15, bottom: 5),
                                  child: Container(
                                    height: 20,
                                    child: TextField(
                                      controller: officeField,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Divider(
                                    height: 1.0, color: Color(0xFFEDEDED)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, bottom: 5, right: 60),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Кв./офис',
                                      style: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 13),
                                    ),
                                    Text(
                                      'Домофон',
                                      style: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 15, bottom: 5),
                                  child: Container(
                                    height: 20,
                                    child: TextField(
                                      controller: floorField,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Divider(
                                    height: 1.0, color: Color(0xFFEDEDED)),
                              ),
//                      Padding(
//                        padding: EdgeInsets.only(left: 15, bottom: 20),
//                        child: _buildTextFormField("Комментарий к заказу"),
//                      ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Комментарий к заказу',
                                      style: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 15, bottom: 5),
                                  child: Container(
                                    height: 20,
                                    child: TextField(
                                      controller: commentField,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Divider(
                                    height: 1.0, color: Color(0xFFEDEDED)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15, left: 15, bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Доставка',
                                      style: TextStyle(
                                          color: Color(0xFFB0B0B0),
                                          fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 15, bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '30 – 50 мин',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                color: Color(0xFAFAFAFA),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Доставка до двери',
                                      style: TextStyle(
                                          color: Color(0xFF3F3F3F),
                                          fontSize: 15),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 0),
                                      child: FlutterSwitch(
                                        width: 55.0,
                                        height: 25.0,
                                        inactiveColor: Color(0xD6D6D6D6),
                                        activeColor: Colors.red,
                                        valueFontSize: 12.0,
                                        toggleSize: 18.0,
                                        value: status1,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: 10,
                                color: Color(0xFAFAFAFA),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, bottom: 5, left: 20),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "Способ оплаты",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFFB0B0B0)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
//                                ListTile(
//                                  leading: SvgPicture.asset('assets/svg_images/dollar_bills.svg'),
//                                  title: Text("Наличными", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.black),),
//                                  trailing: SvgPicture.asset('assets/svg_images/circle.svg'),
//                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, bottom: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                SvgPicture.asset(image),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  child: Text(
                                                    title,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
//                                            Align(
//                                              alignment: Alignment.centerRight,
//                                              child: Padding(
//                                                padding: EdgeInsets.only(left: 180),
//                                                child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
//                                              ),
//                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 8, left: 20, right: 20, top: 0),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              flex: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE32636),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '30 – 50 мин',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )),
                          Flexible(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(right: 20, left: 5),
                                child: Text('Оформить',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              )),
                          Flexible(
                              flex: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE32636),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      '${totalPrice.toStringAsFixed(0)} \Р',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              )),
                        ],
                      ),
                      color: Color(0xFFFE534F),
                      splashColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 20, bottom: 10),
                      onPressed: () async {
                        if (await Internet.checkConnection()) {
                          if (destinationPointsKey.currentState.searchTextField
                                  .textField.controller.text.length >
                              0) {
                            Center(
                              child: CircularProgressIndicator(),
                            );
                            CreateOrder createOrder = new CreateOrder(
                              address: destinationPointsKey.currentState
                                  .searchTextField.textField.controller.text,
                              office: officeField.text,
                              floor: floorField.text,
                              comment: commentField.text,
                              cartDataModel: currentUser.cartDataModel,
                              restaurant: restaurant,
                              payment_type: 'Наличными',
                              door_to_door: status1,
                            );
                            showAlertDialog(context);
                            await createOrder.sendData();
                            currentUser.cartDataModel.cart.clear();
                            currentUser.cartDataModel.saveData();
                            homeScreenKey = new GlobalKey<HomeScreenState>();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                                (Route<dynamic> route) => false);
                          } else {
                            emptyFields(context);
                          }
                        } else {
                          noConnection(context);
                        }
//                        final snackBar = SnackBar(
//                          content: Text('Yay! A SnackBar!'),
//                          action: SnackBarAction(
//                            label: 'Undo',
//                            onPressed: () {
//                              // Some code to undo the change.
//                            },
//                          ),
//                        );
                      },
                    ),
                  ),
                )
              ],
            )));
  }

  void _onPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 100,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  )),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: SvgPicture.asset('assets/svg_images/dollar_bills.svg'),
          title: Text(
            "Наличными",
            style: TextStyle(color: Colors.black),
          ),
          trailing: SvgPicture.asset('assets/svg_images/circle.svg'),
          onTap: () => _selectItem("Наличными"),
        ),
      ],
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      title = name;
      //image = image_name;
    });
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        if (value.isEmpty && hint == "") {
          return "Заполните поле";
        }
      },
      onChanged: (String value) {
        if (hint == "") {
          address = value;
        }
        if (hint == "") {
          office = value;
        }
        if (hint == "") {
          floor = value;
        }
        if (hint == "") {
          comment = value;
        }
        if (hint == "") {
          delivery = value;
        }
      },
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Container(
                height: 100,
                width: 320,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      child: Text(
                        'Идет оплата',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)),
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  emptyFields(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Заполните все поля"),
              ),
            ),
          ),
        );
      },
    );
  }
}

class TakeAway extends StatefulWidget {
  PageState pageState;

  TakeAway({Key key, this.restaurant, this.pageState}) : super(key: key);
  final Records restaurant;
  String name = '';

  @override
  _TakeAwayState createState() => _TakeAwayState(restaurant, pageState);
}

class _TakeAwayState extends State<TakeAway>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String address = 'Адрес доставки';
  String office;
  String floor;
  String comment;
  String delivery;
  final Records restaurant;
  String name = '';
  PageState pageState;
  bool _color;

  noConnection(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 1), () {
          Navigator.of(context).pop(true);
        });
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Container(
              height: 50,
              width: 100,
              child: Center(
                child: Text("Нет подключения к интернету"),
              ),
            ),
          ),
        );
      },
    );
  }

  _TakeAwayState(this.restaurant, this.pageState);

  @override
  void initState() {
    super.initState();
    _color = true;
  }

  String title = 'Наличными';
  String image = 'assets/svg_images/dollar_bills.svg';

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  GlobalKey<AutoCompleteDemoState> destinationPointsKey = new GlobalKey();
  TextEditingController commentField = new TextEditingController();
  final maxLines = 1;

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach(
        (Order order) => totalPrice += order.quantity * order.food.price);
    return Scaffold(
        key: _scaffoldStateKey,
        resizeToAvoidBottomPadding: false,
        body: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                                padding: EdgeInsets.only(right: 0),
                                child: Container(
                                    height: 40,
                                    width: 60,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 12, bottom: 12, right: 20),
                                      child: SvgPicture.asset(
                                          'assets/svg_images/arrow_left.svg'),
                                    ))),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 60),
                          child: Text(
                            "Оформление заказа",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Divider(
                    height: 1,
                    color: Color(0xFFF5F5F5),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 40,
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 10),
                                child: Text(
                                  'Доставка',
                                  style: TextStyle(
                                      color: Color(0xFF999999), fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          onTap: () async {
                            if (await Internet.checkConnection()) {
                              pageState._controller.animateToPage(0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.elasticOut);
                              //pageState._controller.jumpToPage(0);
//                            setState(() {
//                              {
//                                Navigator.pushReplacement(
//                                  context,
//                                  new MaterialPageRoute(
//                                    builder: (context) => new AddressScreen(restaurant: restaurant),
//                                  ),
//                                );}
//                            });
                            } else {
                              noConnection(context);
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(
                        height: 40,
                        child: GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(left: 5, right: 5),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                color: Color(0xFFFE534F),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 40, right: 40, top: 10),
                                child: Text(
                                  'Заберу сам',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _foodItemFormKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: 10, top: 15, left: 15),
                              child: Text(
                                'Адрес заведения',
                                style: TextStyle(
                                    color: Color(0xFFB0B0B0), fontSize: 11),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding:
                                  EdgeInsets.only(bottom: 10, top: 0, left: 15),
                              child: Text(
                                restaurant.name,
                                style: TextStyle(
                                    color: Color(0xFF3F3F3F),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21),
                              )),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(bottom: 20, left: 15),
                              child: Text(
                                restaurant
                                    .destination_points[0].unrestricted_value,
                                style: TextStyle(
                                    color: Color(0xFF3F3F3F), fontSize: 15),
                              )),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Divider(
                          height: 1,
                          color: Color(0xFFF5F5F5),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Комментарий к заказу',
                              style: TextStyle(
                                  color: Color(0xFFB0B0B0), fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 5),
                          child: Container(
                            height: 20,
                            child: TextField(
                              controller: commentField,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Divider(height: 1.0, color: Color(0xFFEDEDED)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, bottom: 5),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Время ожидания',
                              style: TextStyle(
                                  color: Color(0xFFB0B0B0), fontSize: 13),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 15, bottom: 5),
                          child: Container(
                            height: 20,
                            child: TextField(
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                                counterText: '',
                              ),
                            ),
                          )),
                      Container(
                        height: 130,
                        color: Color(0xFAFAFAFA),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Способ оплаты",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB0B0B0)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  SvgPicture.asset(image),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      title,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
//                            Align(
//                              alignment: Alignment.centerRight,
//                              child: Padding(
//                                padding: EdgeInsets.only(left: 200),
//                                child: SvgPicture.asset('assets/svg_images/arrow_right.svg'),
//                              ),
//                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: 8, left: 20, right: 20, top: 9),
                    child: FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                              flex: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE32636),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    '30 – 50 мин',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )),
                          Flexible(
                              flex: 0,
                              child: Padding(
                                padding: EdgeInsets.only(right: 15, left: 5),
                                child: Text('Оформить',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white)),
                              )),
                          Flexible(
                              flex: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFE32636),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      '${totalPrice.toStringAsFixed(0)} \Р',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white)),
                                ),
                              )),
                        ],
                      ),
                      color: Color(0xFFFE534F),
                      splashColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 20, bottom: 10),
                      onPressed: () async {
                        if (await Internet.checkConnection()) {
                          CreateOrderTakeAway createOrderTakeAway =
                              new CreateOrderTakeAway(
                                  comment: comment,
                                  cartDataModel: currentUser.cartDataModel,
                                  restaurant: restaurant);
                          createOrderTakeAway.sendData();
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => new HomeScreen(),
                            ),
                          );
                        } else {
                          noConnection(context);
                        }
                      },
                    ),
                  ),
                ),
              ],
            )));
  }

  void _onPress() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 100,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(30),
                    topRight: const Radius.circular(30),
                  )),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: SvgPicture.asset('assets/svg_images/dollar_bills.svg'),
          title: Text(
            "Наличными",
            style: TextStyle(color: Colors.black),
          ),
          trailing: SvgPicture.asset('assets/svg_images/circle.svg'),
          onTap: () => _selectItem("Наличными"),
        ),
      ],
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      title = name;
      //image = image_name;
    });
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return TextFormField(
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxLine,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        if (value.isEmpty && hint == "Адрес доставки") {
          return "Заполните поле";
        }
        if (value.isEmpty && hint == "Кв./офис  Домофон") {
          return "Заполните поле";
        }

        if (value.isEmpty && hint == "Подъезд  Этаж") {
          return "Заполните поле";
        }

        if (value.isEmpty && hint == "Доставка") {
          return "Заполните поле";
        }

        if (value.isEmpty && hint == "Комментарий к заказу") {
          return "Заполните поле";
        }
      },
      onChanged: (String value) {
        if (hint == "Адрес доставки") {
          address = value;
        }
        if (hint == "Кв./офис  Домофон") {
          office = value;
        }
        if (hint == "Подъезд  Этаж") {
          floor = value;
        }
        if (hint == "Комментарий к заказу") {
          comment = value;
        }
        if (hint == "Доставка") {
          delivery = value;
        }
      },
    );
  }
}
