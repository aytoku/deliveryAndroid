import 'package:flutter/material.dart';
import 'package:food_delivery/test/post_api.dart';
import 'package:food_delivery/test/post_data.dart';

class ApiTest extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Home()
    );
  }
}

class Home extends StatelessWidget{

  callAPI(){
    Post post = Post(
        type: 'restaurant',
        name: 'экспресс',
        page: 1,
        limit: 12
    );
    createPost(post).then((response){
      if(response.statusCode > 200)
        print(response.body);
      else
        print(response.statusCode);
    }).catchError((error){
      print('error : $error');
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body : FutureBuilder<Post>(
            future: getPost(),
            builder: (context, snapshot) {
              callAPI();
              if(snapshot.connectionState == ConnectionState.done) {

                if(snapshot.hasError){
                  return Text("Error");
                }

                return Text('Title from Post JSON : ${snapshot.data.name}');

              }
              else
                return CircularProgressIndicator();
            }
        )
    );
  }

}


//var url = 'https://crm.apis.stage.faem.pro/api/v2/stores';
//var response = await http.post(url, body: {'type': 'restaurant', 'name': 'экспресс','page': '1','limit': '12'});
//if (response.statusCode == 200) {
//var jsonResponse = convert.jsonDecode(response.body);
//var records = jsonResponse['records'];
//print('${records[0]['work_schedule'][0]['week_day']}');
//} else {
//print('Request failed with status: ${response.statusCode}.');
//}
////  print('Response body: ${response.body}');
