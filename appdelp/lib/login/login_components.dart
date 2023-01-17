import 'package:flutter/material.dart';
import 'login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: const [LogoDelp(), FormLogin()],
      ),
    );
  }
}

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => MyFormLogin();
}

class MyFormLogin extends State<FormLogin> {

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.only(top: 200.0),
        child: ListView(
          // ignore: sort_child_properties_last
          children: const [
            // ignore: prefer_const_constructors
            InputUserLogin(),
            InputSenhaLogin(),
            BotaoLogin(),
            BotaoRegistrarLogin()
          ],
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
        ));
  }

}

class LogoDelp extends StatelessWidget {
  const LogoDelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(top: 50.0),
      child: FractionallySizedBox(
        heightFactor: 0.2,
        child: Image.asset(
          alignment: Alignment.topCenter,
          'src/img/logo.png',
        ),
      ),
    );
  }
}

class InputUserLogin extends StatefulWidget {
  const InputUserLogin({super.key});

  @override
  State<InputUserLogin> createState() => _InputUserLoginState();
}

class _InputUserLoginState extends State<InputUserLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80.0),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Email',
            // hintText: 'Usuário',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
          ),
          onChanged: (text) {
            LoginController.instance.setEmail(text);
          },
        ),
      ),
    );
  }
}

class InputSenhaLogin extends StatefulWidget {
  const InputSenhaLogin({super.key});

  @override
  State<InputSenhaLogin> createState() => _InputSenhaLoginState();
}

class _InputSenhaLoginState extends State<InputSenhaLogin> {
  bool password_visible = true;
  Icon password_icon = const Icon(Icons.enhanced_encryption_rounded);
  void alteraSenha() {
    setState(() {
      password_visible = !password_visible;
      password_icon = password_visible == true
          ? const Icon(Icons.enhanced_encryption_rounded)
          : const Icon(Icons.no_encryption_rounded);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 35.0),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: TextField(
          keyboardType: TextInputType.visiblePassword,
          onChanged: (text) {
            LoginController.instance.setPassword(text);
          },
          decoration: InputDecoration(
            labelText: 'Senha',
            // hintText: 'Senha',
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0))),
            suffixIcon: IconButton(onPressed: alteraSenha, icon: password_icon),
          ),
          obscureText: password_visible,
        ),
      ),
    );
  }
}

class BotaoLogin extends StatefulWidget {
  const BotaoLogin({super.key});

  @override
  State<BotaoLogin> createState() => _BotaoLoginState();
}

class _BotaoLoginState extends State<BotaoLogin> {
  Future<void> Logar() async {
    String email = LoginController.instance.getEmail().trim();
    String pass = LoginController.instance.getPassword().trim();
    User? user = null;
    if (email.isNotEmpty && pass.isNotEmpty) {

      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pass,
        );
        final finaluser = userCredential.user;
        user = finaluser;
        if(user!=null && user.emailVerified){

          setState(() {
            Fluttertoast.showToast(
                msg: "Login efetuado com sucesso",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 16.0,
                backgroundColor: Colors.green.shade800,
                webPosition: "center",
                webBgColor: Colors.green.shade800.toString(),);
          });
        
          Navigator.of(context).pushReplacementNamed('/home');

        }
        else if(user!=null){

          if(!user.emailVerified){

            setState(() {
              Fluttertoast.showToast(
                  msg: "Email ainda não foi verificado",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 2,
                  textColor: Colors.white,
                  fontSize: 16.0,
                  backgroundColor: Colors.yellow.shade700,
                  webPosition: "center",
                  webBgColor: Colors.yellow.shade700.toString(),);
            });

          }

        }

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {

          setState(() {
            Fluttertoast.showToast(
                msg: "Email não encontrado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 16.0,
                backgroundColor: Colors.red.shade800,
                webPosition: "center",
                webBgColor: Colors.red.shade800.toString(),);
          });

        } else if (e.code == 'wrong-password') {

          setState(() {
            Fluttertoast.showToast(
                msg: "Senha inválida",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 16.0,
                backgroundColor: Colors.red.shade800,
                webPosition: "center",
                webBgColor: Colors.red.shade600.toString(),);
          });

        }
        else if(e.code == 'user-disabled'){

          setState(() {
            Fluttertoast.showToast(
                msg: "Email não autenticado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 16.0,
                backgroundColor: Colors.grey.shade800,
                webPosition: "center",
                webBgColor: Colors.grey.shade800.toString(),);
          });

        }
        else if (e.code=='invalid-email'){

          setState(() {
            Fluttertoast.showToast(
                msg: "Email não encontrado",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 16.0,
                backgroundColor: Colors.red.shade800,
                webPosition: "center",
                webBgColor: Colors.red.shade800.toString(),);
          });

        }
      }
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 80.0),
      child: FractionallySizedBox(
        widthFactor: 0.4,
        child: TextButton(
          onPressed: Logar,
          // ignore: prefer_const_constructors
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
          ),
          // ignore: prefer_const_constructors
          child: Text(
            'Login',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class BotaoRegistrarLogin extends StatefulWidget {
  const BotaoRegistrarLogin({super.key});

  @override
  State<BotaoRegistrarLogin> createState() => _BotaoRegistrarLoginState();
}

class _BotaoRegistrarLoginState extends State<BotaoRegistrarLogin> {
  void Registrar() {
    Navigator.of(context).pushNamed('/register');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0),
      child: FractionallySizedBox(
        widthFactor: 0.4,
        child: TextButton(
          onPressed: Registrar,
          // ignore: prefer_const_constructors
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
          ),
          // ignore: prefer_const_constructors
          child: Text(
            'Não possuo conta',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
