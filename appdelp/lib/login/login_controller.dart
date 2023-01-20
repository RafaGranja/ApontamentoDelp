import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
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

class Loading extends ChangeNotifier{

  Loading instance = Loading();

  bool carregando = false;

  Widget ret=Container();

  void carregar(){
    if (carregando) {
      ret  = const SpinKitFadingCube(
          color: Colors.red,
          size: 50.0,
        );
    }
    else{
      ret = Container();
    }
  }

}
