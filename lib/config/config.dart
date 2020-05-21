import 'package:device_id/device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NecessaryDataForAuth{
 String device_id;
 String phone_number;
 String refresh_token;

 NecessaryDataForAuth({
   this.device_id,
   this.phone_number,
   this.refresh_token
 });

 static Future<NecessaryDataForAuth> getData() async{
   String device_id = await DeviceId.getID;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String phone_number = prefs.getString('phone_number');
   String refresh_token = prefs.getString('refresh_token');
   NecessaryDataForAuth result = new NecessaryDataForAuth(device_id: device_id, phone_number: phone_number, refresh_token: refresh_token);
   return result;
 }

 static Future<NecessaryDataForAuth> saveData(String phone_number, String refresh_token) async{
   String device_id = await DeviceId.getID;
   SharedPreferences prefs = await SharedPreferences.getInstance();
   prefs.setString('phone_number', phone_number);
   prefs.setString('refresh_token',refresh_token);
   NecessaryDataForAuth result = new NecessaryDataForAuth(device_id: device_id, phone_number: phone_number, refresh_token: refresh_token);
   return result;
 }
}