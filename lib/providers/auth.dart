import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _username;
  DateTime _expiryDate;
  String _userId;
  // Timer _authTimer;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> login(
    String email,
    String password,
  ) async {
    final url = 'http://10.0.2.2:5000/api/subscribers/login';

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['message'] == "Invalid Email or Password") {
        throw HttpException(responseData['message']);
      }

      _token = responseData['token'];
      _username = responseData['name'];
      _userId = responseData['_id'];
      _expiryDate = DateTime.now().add(new Duration(days: 2));
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'username': _username,
        'expiryDate': _expiryDate.toIso8601String(),
      });
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(
    String name,
    String email,
    String password,
  ) async {
    final url = 'http://10.0.2.2:5000/api/subscribers';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'name': name,
            'email': email,
            'password': password,
            'provider': 'local'
          },
        ),
      );
      final responseData = json.decode(response.body);
      print(responseData);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('userData');
    prefs.clear();
  }
}
