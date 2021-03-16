import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:ecommerce/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get isFeatured {
    return [..._items.where((feature) => feature.isFeatured == true)];
  }

  List<Product> get newArrival {
    return [..._items.where((feature) => feature.newArrival == true)];
  }

  Future<void> fetchAndSetProducts() async {
    var url = "https://backend.trishapta.com/api/products/";
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      if (extractedData == null) {
        return;
      }
      List<dynamic> data;
      data = extractedData['products'];

      data.forEach((prodData) {
        loadedProducts.add(
          Product(
            id: prodData['_id'],
            name: prodData['name'],
            description: prodData['description'],
            sellingPrice: prodData['sellingPrice'],
            heroImage: 'https://demo.trishapta.com${prodData['hero_image']}',
            techspecs: prodData['techincal'],
            isFeatured: prodData['isFeatured'],
            newArrival: prodData['newArrival'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
