import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/Internet/check_internet.dart';
import 'package:food_delivery/PostData/chat.dart';
import 'package:food_delivery/data/data.dart';
import 'package:food_delivery/models/ChatHistoryModel.dart';

import 'home_screen.dart';

class ServiceChatScreen extends StatefulWidget {
  String order_uuid;

  ServiceChatScreen({Key key, this.order_uuid}) : super(key: key);

  @override
  ChatScreenState createState() {
    return new ChatScreenState(order_uuid);
  }
}

class ServiceChatScreenState extends State<ServiceChatScreen> with WidgetsBindingObserver {
  List<ChatMessageScreen> chatMessageList;
  String order_uuid;

  ServiceChatScreenState(this.order_uuid);

  TextEditingController messageField = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      setState(() {

      });
    }
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

  buildChat() {
    List<String> messagedUuid = new List<String>();
    chatMessageList.forEach((element) {
      if (element.chatMessage.to == 'client' &&
          element.chatMessage.ack == false) {
        element.chatMessage.ack = false;
        messagedUuid.add(element.chatMessage.uuid);
      }
    });
    if (messagedUuid.length > 0) {
      Chat.readMessage(messagedUuid);
    }
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: Stack(children: <Widget>[
                InkWell(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: 0, top: 30),
                          child: Container(
                              height: 40,
                              width: 60,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12, bottom: 12, right: 10),
                                child: SvgPicture.asset(
                                    'assets/svg_images/arrow_left.svg'),
                              )))),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => new HomeScreen(),
                      ),
                    );
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 40, left: 0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Чат с водителем',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ))
              ]),
            ),
            Align(
                alignment: Alignment.center,
                child: Container(
                  height: 450,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: chatMessageList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return chatMessageList[chatMessageList.length-1-index];
                      },
                      //chatMessageList
                    ),
                  ),
                )
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (chatMessageList != null) {
      print(chatMessageList.length);
      return buildChat();
    }
    return FutureBuilder<ChatHistoryModel>(
      future: Chat.loadChatHistory(order_uuid, 'driver'),
      builder:
          (BuildContext context, AsyncSnapshot<ChatHistoryModel> snapshot) {
        print('tututuwapatututuwapa ' + order_uuid);
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          chatMessagesStates.clear();
          chatMessageList = new List<ChatMessageScreen>();
          snapshot.data.chatMessageList.forEach((element) {
            GlobalKey<ChatMessageScreenState> chatMessageScreenStateKey =
            new GlobalKey<ChatMessageScreenState>();
            chatMessagesStates[element.uuid] = chatMessageScreenStateKey;
            chatMessageList.add(new ChatMessageScreen(
                chatMessage: element, key: chatMessageScreenStateKey));
          });
//          GlobalKey<ChatMessageScreenState> chatMessageScreenStateKey =
//              new GlobalKey<ChatMessageScreenState>();
          //chatMessagesStates['123'] = chatMessageScreenStateKey;
//          chatMessageList.add(new ChatMessageScreen(
//              key: chatMessageScreenStateKey,
//              chatMessage: new ChatMessage(
//                  message: 'halo',
//                  ack: false,
//                  uuid: '123',
//                  from: 'driver',
//                  to: 'client')
//          ));
          return buildChat();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}