import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ecommerce/providers/carousal.dart';
import 'package:http/http.dart' as http;

class Carousals with ChangeNotifier {
  List<Carousal> _items = [];

  List<Carousal> get items {
    return [..._items];
  }

  Future<void> fetchAndSetCarousal() async {
    var url = 'https://backend.trishapta.com/api/carousel';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Carousal> loadedCarousal = [];
      if (extractedData == null) {
        return;
      }
      List<dynamic> data;
      data = extractedData['images'];
      data.forEach((carouData) {
        loadedCarousal.add(Carousal(
          id: carouData['_id'],
          link: carouData['link'],
          image: 'https://demo.trishapta.com${carouData['image']}',
        ));
      });
      _items = loadedCarousal;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
