import 'package:food_delivery/models/ResponseData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAddressesModel{
  MyAddressesType type;
  String address;
  String name;
  int index;

  MyAddressesModel( {
    this.type,
    this.address,
    this.name,
    this.index
  });

  static Future<int> getRecordCount() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey('address_count')){
      prefs.setInt('address_count', 0);
    }
    return prefs.getInt('address_count');
  }

  static Future setRecordsCount(int count) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('address_count', count);
  }

  static Future saveData(MyAddressesModel myAddressesModel) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(myAddressesModel.index == null){
      int count = await getRecordCount();
      await setRecordsCount(count + 1);
      myAddressesModel.index = count;
    }
    print('sdf');
    prefs.setString('address_value_' + myAddressesModel.index.toString(), myAddressesModel.address);
    prefs.setString('address_name_' + myAddressesModel.index.toString(), myAddressesModel.name);
    prefs.setInt('address_type_' + myAddressesModel.index.toString(), myAddressesModel.type.index);
  }

  static Future<List<MyAddressesModel>> getAddresses() async{
    List<MyAddressesModel> result = new List<MyAddressesModel>();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int count = await getRecordCount();
    for(int i = 0; i < count; i++){
      String address = prefs.getString('address_value_' + i.toString());
      String name = prefs.getString('address_name_' + i.toString());
      MyAddressesType type = prefs.getInt('address_type_' + i.toString()) == 0 ? MyAddressesType.empty : MyAddressesType.home;
      result.add(new MyAddressesModel(address: address, name: name, index: i, type: type));
    }
    return result;
  }
}

enum MyAddressesType{empty, home}