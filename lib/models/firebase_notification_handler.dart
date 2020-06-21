import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_delivery/PostData/current_data_about_order.dart';
import 'package:food_delivery/PostData/fcm.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/OrderStoryModel.dart';
import 'package:food_delivery/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging;

  Future setUpFirebase() async{
    _firebaseMessaging = FirebaseMessaging();
    await firebaseCloudMessaging_Listeners();
  }

  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
    print(message);
    print('EXPLOOOOSION');
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }
    // Or do other work.
  }

  static Future<void> OrderCheckingUpdater(String order_uuid, String order_state) async {
    if(orderCheckingStates.containsKey(order_uuid)) {
      orderCheckingStates[order_uuid].currentState.setState(() {
        orderCheckingStates[order_uuid].currentState.ordersStoryModelItem
            .state = order_state;
      });
    }
  }

  void firebaseCloudMessaging_Listeners() async{
    if (Platform.isIOS) iOS_Permission();
    var token = await _firebaseMessaging.getToken();
    FCMToken = token;
    await sendFCMToken(token);
    print('DAITE MNE TOKEN   ' + token);

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        if (message.containsKey('data')) {
          var data =  message['data'];
          if(data.containsKey('tag') && data['tag'] == 'order_state') {
            print('ora');
            var payload = convert.jsonDecode(data['payload']);
            String order_state = payload['state'];
            String order_uuid = payload['order_uuid'];
            print('containwsadsfsdfgsdfg');
            OrderCheckingUpdater(order_uuid, order_state);
          }
        }
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}