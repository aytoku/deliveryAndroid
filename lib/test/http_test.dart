import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Album> fetchAlbum() async {
  final response =
  await http.get('https://crm.apis.stage.faem.pro/api/v2/stores');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
//  final int page;
//  final int limit;
  final String uuid;
  final String name ;

  Album({ this.uuid, this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      uuid: json['uuid'],
      name: json['name'],
    );
  }
}

class HttpTest extends StatefulWidget {
  HttpTest({Key key}) : super(key: key);

  @override
  _HttpTestState createState() => _HttpTestState();
}

class _HttpTestState extends State<HttpTest> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    Text(snapshot.data.uuid),
                    Text(snapshot.data.name),
//                    Text('${snapshot.data.page}'),
//                    Text('${snapshot.data.limit}'),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              // By default, show a loading spinner.
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}