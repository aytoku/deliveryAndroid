//import 'dart:async' show Future;
//import 'package:flutter/services.dart' show rootBundle;
//import 'dart:convert';
//
//import 'package:food_delivery/models/ResponseData.dart';
//
//Future<String> _loadProductAsset() async {
//  return await rootBundle.loadString('https://crm.apis.stage.faem.pro/api/v2/stores');
//}
///*
//Product _parseJsonForCrossword(String jsonString) {
//  Map JSON = json.decode(jsonString);
//  List<Image> words = new List<Image>();
//  for (var word in JSON['across']) {
//    words.add(new Image(word['number'], word['word']));
//  }
//  return new Product(JSON['id'], JSON['name'], new Image(words));
//}
//*/
//
//Future loadProduct() async {
//  String jsonProduct = await _loadProductAsset();
//  final jsonResponse = json.decode(jsonProduct);
//  DeliveryResponseData product = new DeliveryResponseData.fromJson(jsonResponse);
//  print(product.work_schedule[0].week_day);
//}