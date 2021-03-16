// import 'dart:convert';

import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final int sellingPrice;
  final String heroImage;
  var techspecs = [];
  bool isFeatured;
  bool newArrival;

  Product({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.sellingPrice,
    @required this.heroImage,
    @required this.techspecs,
    this.isFeatured,
    this.newArrival,
  });
}
