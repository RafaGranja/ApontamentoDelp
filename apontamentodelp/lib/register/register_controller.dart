
import 'package:flutter/cupertino.dart';

class RegisterController extends ChangeNotifier {
  static RegisterController instance = RegisterController();
  String email = "";
  String password1 = "";
  String password2 = "";

  void setEmail(String email2) {
    email = email2;
  }

  String getEmail() {
    return email;
  }

  void setPassword1(String password3) {
    password1 = password3;
  }

  String getPassword1() {
    return password1;
  }

  void setPassword2(String password3) {
    password2 = password3;
  }

  String getPassword2() {
    return password2;
  }
}
