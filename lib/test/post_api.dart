import 'package:food_delivery/test/post_data.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';


String url = 'https://crm.apis.stage.faem.pro/api/v2/stores';

Future<List<Post>> getAllPosts() async {
  final response = await http.get(url);
  print(response.body);
  return allPostsFromJson(response.body);
}

Future<Post> getPost() async{
  final response = await http.get('$url/1');
  return postFromJson(response.body);
}

Future<http.Response> createPost(Post post) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
      body: postToJson(post)
  );
  return response;
}