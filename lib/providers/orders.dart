import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken, this._orders, this.userId);
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders(token) async {
    final url = 'https://backend.trishapta.com/api/orders/myorders';

    final response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "authorization": 'Bearer $token',
    });

    final List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body);

    if (extractedData == null) {
      return;
    }
    List<dynamic> data;
    data = extractedData;
    data.forEach((orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderData['_id'],
          amount: orderData['totalPrice'] + .0,
          dateTime: DateTime.parse(orderData['updatedAt']),
          products: (orderData['orderItems'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  id: item['_id'],
                  title: item['name'],
                  quantity: item['qty'],
                  price: item['price'] + .0,
                  image: item['image'],
                  product: item['product'],
                ),
              )
              .toList(),
        ),
      );
    });

    _orders = loadedOrders.reversed.toList();

    notifyListeners();
  }

  Future<void> addOrder(
      List<CartItem> cartProducts, double total, token) async {
    final url = 'https://backend.trishapta.com/api/orders';
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token',
      },
      body: json.encode(
        {
          'totalPrice': total,
          'orderItems': cartProducts
              .map(
                (cp) => {
                  'product': cp.product,
                  'name': cp.title,
                  'image': cp.image,
                  'price': cp.price,
                  'qty': cp.quantity,
                },
              )
              .toList(),
          'address': 'XYZ road',
          'paymentMethod': 'credit',
        },
      ),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        amount: total,
        dateTime: timestamp,
        products: cartProducts,
      ),
    );
    notifyListeners();
  }
}
