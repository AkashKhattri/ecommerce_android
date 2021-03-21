import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:ecommerce/providers/category.dart';
import 'package:http/http.dart' as http;

class Categories with ChangeNotifier {
  List<Category> _items = [];
  List<Category> get items {
    return [..._items];
  }

  Future<void> fetchAndSetCategories() async {
    List<dynamic> data;

    var url = 'https://backend.trishapta.com/api/categories';

    try {
      final response = await http.get(url);

      final extractedData = json.decode(response.body) as Map<String, dynamic>;

      List<Category> loadedCategories = [];

      if (extractedData == null) {
        return;
      }
      data = extractedData['categories'];

      // if (products[5]['category'] != null) {
      //   print('exists');
      //   return;
      // } else {
      //   print('dont exist');
      //   return;
      // }

      data.forEach((catData) {
        loadedCategories.add(
          Category(
            id: catData['_id'],
            name: catData['name'],
            subCategory: catData['subCategories'],
          ),
        );
      });

      _items = loadedCategories;
      print(_items.length);

      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
