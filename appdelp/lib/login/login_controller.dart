import 'package:flutter/cupertino.dart';

class LoginController extends ChangeNotifier {
  static LoginController instance = LoginController();
  String email = "";
  String password = "";

  void setEmail(String email2) {
    email = email2;
  }

  String getEmail() {
    return email;
  }

  void setPassword(String password2) {
    password = password2;
  }

  String getPassword() {
    return password;
  }
}
