import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController name = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController pass = TextEditingController();

  var gname;
  var gmail;
  var gpass;
  bool islogin = false;
  bool _isLoading = true;
  LoginProvider() {
    _checkLoginStatus();
  }
  Future<void> _checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    islogin = prefs.getBool('islogin') ?? false;
    notifyListeners();
  }

  Future<void> addDetails(name, pass, mail) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('pass', pass);
    await prefs.setString('mail', mail);
    await prefs.setBool('islogin', true);
    islogin = true;

    notifyListeners();
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('islogin', false);
    islogin = false;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> getDetails() async {
    _isLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    gname = prefs.getString('name');

    gpass = prefs.getString('pass');

    gmail = prefs.getString('mail');

    _isLoading = false;
    notifyListeners();
  }
}
