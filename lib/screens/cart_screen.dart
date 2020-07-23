import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ResponseData.dart';
import 'package:food_delivery/models/food.dart';
import 'package:food_delivery/models/order.dart';
import 'package:food_delivery/scopped_model/main_model.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:food_delivery/screens/restaurant_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'address_screen.dart';
import 'auth_screen.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key key, this.restaurant}) : super(key: key);
  final Records restaurant;

  @override
  _CartScreenState createState() => _CartScreenState(restaurant);
}

class _CartScreenState extends State<CartScreen> {
  String title;
  String category;
  String description;
  String price;
  String discount;
  final Records restaurant;
  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();
  double total;
  bool delete = false;

  _CartScreenState(this.restaurant);

  _buildList() {
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach(
        (Order order) => totalPrice += order.quantity * order.food.price);
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        itemCount: currentUser.cartDataModel.cart.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index < currentUser.cartDataModel.cart.length) {
            Order order = currentUser.cartDataModel.cart[index];
            return Dismissible(
              key: Key(currentUser.cartDataModel.cart[index].food.uuid),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  currentUser.cartDataModel.cart.removeAt(index);
                  currentUser.cartDataModel.saveData();
                });
                if (currentUser.cartDataModel.cart.length == 0) {
                  Navigator.pushReplacement(
                    context,
                    new MaterialPageRoute(
                      builder: (context) =>
                          new EmptyCartScreen(restaurant: restaurant),
                    ),
                  );
                }
              },
              direction: DismissDirection.endToStart,
              child: Container(
                color: Colors.white,
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: _buildCartItem(order),
              ),
            );
          }
          return Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Итого',
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                      ),
                      Text('${totalPrice.toStringAsFixed(0)} \Р',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF000000))),
                    ],
                  ),
                  SizedBox(height: 80.0)
                ],
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1.0,
            color: Color(0xFFF5F5F5),
          );
        },
      ),
    );
  }

  _buildCartItem(Order order) {
    GlobalKey<CounterState> counterKey = new GlobalKey();
    return Container(
        padding: EdgeInsets.all(5.0),
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 3,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  !order.isSelected
                      ? Padding(
                          padding:
                              EdgeInsets.only(top: 15, bottom: 15, left: 10),
                          child: Text(
                            '${order.quantity.toStringAsFixed(0)}',
                            style: TextStyle(
                                decoration: TextDecoration.none,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF000000)),
                          ),
                        )
                      : Counter(
                          key: counterKey,
                          initial_counter: order.quantity,
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 15, bottom: 15),
                    child: SvgPicture.asset('assets/svg_images/cross.svg'),
                  ),
                  Expanded(
                    child: Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                order.food.name,
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            (order.food.variants != null)
                                ? Text(
                                    order.food.variants[0].name,
                                    style: TextStyle(
                                        decoration: TextDecoration.none,
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF000000)),
                                    textAlign: TextAlign.start,
                                  )
                                : Text(''),
                            (order.food.toppings != null)
                                ? Column(
                                    children: List.generate(
                                        order.food.toppings.length,
                                        (index) => Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  order.food.toppings[index]
                                                      .name,
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xFF000000)),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            )),
                                  )
                                : Text(''),
                          ],
                        )),
                  )
                ]),
              ),
              Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text('${order.quantity * order.food.price} \Р',
                        style: TextStyle(
                            decoration: TextDecoration.none,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFB0B0B0))),
                  )),
            ],
          ),
          onTap: () {
            setState(() {
              if (order.isSelected) {
                order.quantity = counterKey.currentState.counter;
              }
              order.isSelected = !order.isSelected;
            });
          },
        ));
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
                height: 202,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15, top: 20, bottom: 20),
                      child: Text(
                        'Вы действительно хотите\nотчистить корзину?',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF424242)),
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Center(
                              child: Text(
                                'Очистить',
                                style: TextStyle(
                                    color: Color(0xFFFF0600),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      onTap: () {
                        setState(() {
                          currentUser.cartDataModel.cart.clear();
                          currentUser.cartDataModel.saveData();
                        });
                        Navigator.pushReplacement(
                          context,
                          new MaterialPageRoute(
                            builder: (context) =>
                                new EmptyCartScreen(restaurant: restaurant),
                          ),
                        );
                      },
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    InkWell(
                      child: Container(
                        child: Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Center(
                              child: Text(
                                'Отмена',
                                style: TextStyle(
                                    fontSize: 17, color: Color(0xFF424242)),
                              ),
                            )),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                )),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();
    double totalPrice = 0;
    currentUser.cartDataModel.cart.forEach(
        (Order order) => totalPrice += order.quantity * order.food.price);
    Order bloc;
    return new Scaffold(
      key: _scaffoldStateKey,
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 0,
                          child: Padding(
                            padding: EdgeInsets.only(left: 0),
                            child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                    height: 40,
                                    width: 60,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 12, bottom: 12, right: 25),
                                      child: SvgPicture.asset(
                                          'assets/svg_images/arrow_left.svg'),
                                    ))),
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Text(
                              restaurant.name,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF3F3F3F)),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: GestureDetector(
                                    child: SvgPicture.asset(
                                        'assets/svg_images/delete.svg'),
                                    onTap: () {
                                      showAlertDialog(context);
                                    },
                                  ))),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Container(
                        color: Color(0xFFF5F5F5),
                        height: 10,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Доставка еды",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF000000),
                                  fontSize: 14),
                            ),
                            Padding(
                              padding: EdgeInsets.only(),
                              child: Text(
                                "134 Р",
                                style: TextStyle(
                                    color: Color(0xFFB0B0B0), fontSize: 14),
                              ),
                            ),
                          ],
                        )
                    ),
                    Container(
                      color: Color(0xFFF5F5F5),
                      height: 10,
                      width: MediaQuery.of(context).size.width,
                    ),
//                    Container(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
////                          Row(
////                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                            children: <Widget>[
////                              Padding(
////                                padding: EdgeInsets.only(
////                                    left: 15, top: 5, bottom: 5),
////                                child: Text(
////                                  "Закажите еще на 1000 Р. для бесплатной\nдоставки",
////                                  style: TextStyle(
////                                      color: Color(0xFF000000), fontSize: 12),
////                                ),
////                              ),
////                              Padding(
////                                padding: EdgeInsets.only(right: 15, bottom: 10),
////                                child: Text(
////                                  "134 Р",
////                                  style: TextStyle(
////                                      color: Color(0xFFB0B0B0), fontSize: 14),
////                                ),
////                              ),
////                            ],
////                          ),
//                        ],
//                      ),
//                    ),
                  ],
                ),
              ),
              _buildList(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 15, right: 15, left: 15, bottom: 15),
                  child: FlatButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                            flex: 1,
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
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 15,
                              ),
                              child: Text('Далее',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white)),
                            )),
                        Flexible(
                            flex: 1,
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(
                        left: 10, top: 10, right: 10, bottom: 10),
                    onPressed: () async {
                      if (await Internet.checkConnection()) {
                        if (currentUser.isLoggedIn) {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new PageScreen(restaurant: restaurant)),
                          );
                        } else {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => new AuthScreen()),
                          );
                        }
                      } else {
                        noConnection(context);
                      }
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

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
}

class Counter extends StatefulWidget {
  final int initial_counter;

  Counter({Key key, this.initial_counter}) : super(key: key);

  @override
  CounterState createState() {
    return new CounterState(counter: initial_counter);
  }
}

class CounterState extends State<Counter> {
  int counter = 1;

  CounterState({this.counter});

  // ignore: non_constant_identifier_names
  void _incrementCounter_plus() {
    setState(() {
      counter++;
    });
  }

  // ignore: non_constant_identifier_names
  void _incrementCounter_minus() {
    setState(() {
      counter--;
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0, left: 15),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Color(0xF5F5F5F5))),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.only(left: 5),
            child: GestureDetector(
              onTap: () {
                if (counter != 1) {
                  _incrementCounter_minus();
                }
              },
              child: Text(
                '-',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Text(
              '$counter',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _incrementCounter_plus();
                });
              },
              child: Text(
                '+',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }

  void refresh() {
    setState(() {});
  }
}

class EmptyCartScreen extends StatefulWidget {
  final Records restaurant;

  EmptyCartScreen({Key key, this.restaurant}) : super(key: key);

  @override
  EmptyCartScreenState createState() {
    return new EmptyCartScreenState(restaurant);
  }
}

class EmptyCartScreenState extends State<EmptyCartScreen> {
  final Records restaurant;

  EmptyCartScreenState(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: InkWell(
                        onTap: () {
                          homeScreenKey = new GlobalKey<HomeScreenState>();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                                  (Route<dynamic> route) => false);
                        },
                        child: Padding(
                            padding: EdgeInsets.only(right: 0),
                            child: Container(
                                width: 40,
                                height: 60,
                                child: Center(
                                  child: SvgPicture.asset(
                                      'assets/svg_images/arrow_left.svg'),
                                ))),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: Text(
                        'Корзина',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF000000)),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: GestureDetector(
                              child: SvgPicture.asset(
                                  'assets/svg_images/delete.svg'),
                            ))),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: Image(
                          image: AssetImage('assets/images/basket.png'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                          child: Text(
                        'Корзина пуста',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Color(0xFF424242)),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 100),
                      child: Center(
                        child: Text(
                          'Перейдите в список мест, чтобы\nоформить заказ заново',
                          style:
                              TextStyle(color: Color(0xFFB0B0B0), fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 15),
                  child: FlatButton(
                    child: Text(
                      'Вернуться на главную',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    color: Color(0xFFFE534F),
                    splashColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(
                        left: 80, top: 20, right: 80, bottom: 20),
                    onPressed: () {
                      homeScreenKey = new GlobalKey<HomeScreenState>();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeScreen()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
