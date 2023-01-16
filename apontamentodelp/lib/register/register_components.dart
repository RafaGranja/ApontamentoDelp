import 'package:apontamentodelp/register/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../login/login_components.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
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
        children: const [LogoDelp(), FormRegister()],
      ),
    );
  }
}

class FormRegister extends StatefulWidget {
  const FormRegister({super.key});

  @override
  State<FormRegister> createState() => MyFormRegister();
}

class MyFormRegister extends State<FormRegister> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 200.0),
        child: ListView(
          // ignore: sort_child_properties_last
          children: const [
            // ignore: prefer_const_constructors
            InputUserRegister(),
            InputSenhaRegister(),
            InputConfirmarSenhaRegister(),
            BotaoRegistrar(),
          ],
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
        ));
  }
}

class InputUserRegister extends StatefulWidget {
  const InputUserRegister({super.key});

  @override
  State<InputUserRegister> createState() => _InputUserRegisterState();
}

class _InputUserRegisterState extends State<InputUserRegister> {
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
            RegisterController.instance.setEmail(text);
          },
        ),
      ),
    );
  }
}

class InputSenhaRegister extends StatefulWidget {
  const InputSenhaRegister({super.key});

  @override
  State<InputSenhaRegister> createState() => _InputSenhaRegisterState();
}

class _InputSenhaRegisterState extends State<InputSenhaRegister> {
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
            RegisterController.instance.setPassword1(text);
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

class InputConfirmarSenhaRegister extends StatefulWidget {
  const InputConfirmarSenhaRegister({super.key});

  @override
  State<InputConfirmarSenhaRegister> createState() =>
      _InputConfirmarSenhaRegisterState();
}

class _InputConfirmarSenhaRegisterState
    extends State<InputConfirmarSenhaRegister> {
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
            RegisterController.instance.setPassword2(text);
          },
          decoration: InputDecoration(
            labelText: 'Confirmar Senha',
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

class BotaoRegistrar extends StatefulWidget {
  const BotaoRegistrar({super.key});

  @override
  State<BotaoRegistrar> createState() => _BotaoRegistrarState();
}

class _BotaoRegistrarState extends State<BotaoRegistrar> {
  Future<void> Registrar() async {
    String email = RegisterController.instance.getEmail().trim();
    String pass1 = RegisterController.instance.getPassword1().trim();
    String pass2 = RegisterController.instance.getPassword2().trim();
    User? user = null;
    if (email != "" && email.isNotEmpty) {
      if (pass1.isNotEmpty && pass2.isNotEmpty && pass1 == pass2) {
        if(pass1.length > 6){
          try {
            UserCredential  credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email,
              password: pass1,
            );
            final finaluser = credential.user;
            user = finaluser;
            if(user!=null){

              await finaluser?.sendEmailVerification();

              setState(() {
                Fluttertoast.showToast(
                      msg: "Usuário cadastrado com sucesso, verifique seu email",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      backgroundColor: Colors.green.shade500,
                      webPosition: "center",
                      webBgColor: Colors.green.shade500.toString(),);

                Navigator.of(context).pushReplacementNamed('/login');
              });

            }
            else{

              setState(() {
                Fluttertoast.showToast(
                      msg: "Erro ao cadastrar usuário",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      backgroundColor: Colors.red.shade800,
                      webPosition: "center",
                      webBgColor: Colors.red.shade800.toString(),
                      );
              });
              return;

            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
              setState(() {
                Fluttertoast.showToast(
                      msg: "Senha inserida é fraca para o cadastro",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 2,
                      textColor: Colors.white,
                      fontSize: 16.0,
                      backgroundColor: Colors.red.shade800,
                      webPosition: "center",
                      webBgColor: Colors.red.shade800.toString(),);
              });
            } else if (e.code == 'email-already-in-use') {
              setState(() {
                Fluttertoast.showToast(
                      msg: "O email inserido já está cadastrado",
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
            else if(e.code=='network-request-failed'){

              setState(() {
                Fluttertoast.showToast(
                      msg: "Falha de conexão",
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
          } catch (e) {
            print(e);
          }
          
        }
      else{

          setState(() {
            Fluttertoast.showToast(
                msg: "Senha deve ter mais de 6 caracteres",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 16.0,
                backgroundColor: Colors.grey.shade800,
                webPosition: "center",
                webBgColor: Colors.grey.shade800.toString(),);
          });
          return;
        }

      } else {
        setState(() {
          Fluttertoast.showToast(
              msg: "As senhas precisam ser iguais",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              textColor: Colors.white,
              fontSize: 16.0,
              backgroundColor: Colors.grey.shade800,
              webPosition: "center",
              webBgColor: Colors.grey.shade800.toString(),);
        });
        return;
      }
    } else {

      setState(() {
          Fluttertoast.showToast(
              msg: "Insira um email",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              textColor: Colors.white,
              fontSize: 16.0,
              backgroundColor: Colors.grey.shade800,
              webPosition: "center",
              webBgColor: Colors.grey.shade800.toString(),);
      });
      return;

    }
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
            'Registrar',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
