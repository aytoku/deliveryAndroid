import 'dart:convert';
import 'package:food_delivery/models/order_redister.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:food_delivery/models/food.dart';
import 'package:http/http.dart' as http;

class  FoodModel extends Model {
  List<Food> _foods = [];
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  List<Food> get foods {
    return List.from(_foods);
  }

  Future<bool> addFood(Food food) async {
    _isLoading = true;
    notifyListeners();

    try {
      final Map<String, dynamic> foodData = {
        "address": food.address,
        "office": food.office,
        "floor":food.floor,
        "comment": food.comment,
        "name": food.name,
        "price": food.price,
      };
      final http.Response response = await http.post(
          "https://food-cb2e1.firebaseio.com/foods.json",
          body: json.encode(foodData));

      final Map<String, dynamic> responeData = json.decode(response.body);

      Food foodWithID = Food(
        id: responeData["name"],
        address: food.address,
        office: food.office,
        floor: food.floor,
        comment: food.comment,
        name: food.name,
        price: food.price,
      );

      _foods.add(foodWithID);
      _isLoading = false;
      notifyListeners();
      // fetchFoods();
      return Future.value(true);
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }

  Future<bool> fetchFoods() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response =
      await http.get("https://food-cb2e1.firebaseio.com/foods.json");

      // print("Fecthing data: ${response.body}");
      final Map<String, dynamic> fetchedData = json.decode(response.body);
      print(fetchedData);

      final List<Food> foodItems = [];

      fetchedData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
          id: id,
          name: foodData['name'],
          price: foodData['price']
        );

        foodItems.add(foodItem);
      });

      _foods = foodItems;
      _isLoading = false;
      notifyListeners();
      return Future.value(true);
    } catch (error) {
      _isLoading = false;
      notifyListeners();
      return Future.value(false);
    }
  }
}
//class _FavoritePageState extends State<FavoritePage> {
//
//  // the scaffold global key
//  GlobalKey<ScaffoldState> _explorePageScaffoldKey = GlobalKey();
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    widget.model.fetchFoods();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: _explorePageScaffoldKey,
//      backgroundColor: Colors.white,
//      body: ScopedModelDescendant<MainModel>(
//        builder: (BuildContext sctx, Widget child, MainModel model) {
//          //model.fetchFoods(); // this will fetch and notifylisteners()
//          // List<Food> foods = model.foods;
//          return Container(
//            padding: EdgeInsets.symmetric(horizontal: 20.0),
//            child: RefreshIndicator(
//              onRefresh: model.fetchFoods,
//              child: ListView.builder(
//                itemCount: model.foodLength,
//                itemBuilder: (BuildContext lctx, int index) {
//                  return GestureDetector(
//                    onTap: () async {
//                      final bool response =
//                      await Navigator.of(context).push(MaterialPageRoute(
//                          builder: (BuildContext context) => AddFoodItem(
//                            food: model.foods[index],
//                          )));
//
//                      if (response) {
//                        SnackBar snackBar = SnackBar(
//                          duration: Duration(seconds: 2),
//                          backgroundColor: Theme.of(context).primaryColor,
//                          content: Text(
//                            "Food item successfully updated.",
//                            style:
//                            TextStyle(color: Colors.white, fontSize: 16.0),
//                          ),
//                        );
//                        _explorePageScaffoldKey.currentState.showSnackBar(snackBar);
//                      }
//                    },
//                    child: FoodItemCard(
//                      model.foods[index].name,
//                      model.foods[index].description,
//                      model.foods[index].price.toString(),
//                    ),
//                  );
//                },
//              ),
//            ),
//          );
//        },
//      ),
//    );
//  }
//}
