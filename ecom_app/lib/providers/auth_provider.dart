import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import '../networks/auth_service.dart';

class Auth with ChangeNotifier {
  String _token = "";
  User? currentUser;
  String message = '';
  String? error;
  Auth() {
    tryAutoLogin();
    // getUser();
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userToken')) {
      _token = "";
    } else {
      String? token = prefs.getString('userToken');
      final storedData = json.decode(token ?? '');
      // print(storedData);
      _token = storedData['token'];
    }

    notifyListeners();
  }

  bool get isAuth {
    if (_token != "") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> login(Map<String, String> data) async {
    var response = await AuthService.login(data);
    _token = response["token"];
    final prefs = await SharedPreferences.getInstance();
    final storedData = json.encode({'token': _token});
    prefs.setString('userToken', storedData);
    notifyListeners();
  }

  Future<void> register(Map<String, String> data) async {
    var result = await AuthService.register(data);
    if (result == 500) {
      error = 'User already exist';
    } else {
      error = null;
    }
    notifyListeners();
  }
}
