import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../dateInput/date.dart';
import '../dateInput/time.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NovaAtividade extends StatefulWidget {
  const NovaAtividade({super.key});

  @override
  State<NovaAtividade> createState() => _NovaAtividadeState();
}

class _NovaAtividadeState extends State<NovaAtividade> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1.0,
      widthFactor: 0.9,
      alignment: Alignment.center,
        child: ListView(
          children: const[
          CamposHoras(),
          ClienteInput(),
          ProjetoInput(),
          NoteInput(),
          Adicionar(),
          ]),
    );
  }
}

class NoteInput extends StatefulWidget {
  const NoteInput({super.key});

  @override
  State<NoteInput> createState() => _NoteInputState();
}

class _NoteInputState extends State<NoteInput> {

  final TextEditingController noteinput = TextEditingController(); 

  @override
  void initState() {
    noteinput.text = NoteController.instance.nota; //set the initial value of text field
    super.initState();
    
    noteinput.addListener(() {
      final String text = NoteController.instance.nota;
      noteinput.value = noteinput.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });

  }

  @override
  Widget build(BuildContext context) {

    noteinput.text = NoteController.instance.nota;

    return 
    Container(
      margin: EdgeInsets.only(top:(MediaQuery.of(context).size.width)/20),
      height: (MediaQuery.of(context).size.height)/10,
      child:TextField(
              maxLines: 5,
              decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(20.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              label: Text('Anotações',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (text) {
                NoteController.instance.nota=text;
              },
              controller: noteinput,
            )
    );
  }
  
}

class Adicionar extends StatefulWidget {
  const Adicionar({super.key});

  @override
  State<Adicionar> createState() => _AdicionarState();
}

class _AdicionarState extends State<Adicionar> {

  var list = <Map>[];

  CollectionReference tasks = FirebaseFirestore.instance.collection('TAREFAS');

  Future<void> addTask() async {
    list.clear();

    await tasks.doc(FirebaseAuth.instance.currentUser?.uid.toString()).get()
          .then((value){
            var reg = value.get("REGISTROS");
            for (var i = 0; i < reg.length; i++) {
              var row = {};
              row = reg[i];
                list.add({
                  'ID' : i,
                'DTINICIAL': row['DTINICIAL'], 
                'DTFINAL': row['DTFINAL'],
                'HRINICIAL': row['HRINICIAL'], 
                'HRFINAL' : row['HRFINAL'], 
                'PROJETO' : row['PROJETO'], 
                'CLIENTE': row['CLIENTE'], 
                'NOTA' : row['NOTA'], 
              });
            }
          }).catchError((error) => print("Falha ao incluir registro: $error"));
  
    list.add({
      'ID':list.length,
      'DTINICIAL': DateInput.instance.text1, 
      'DTFINAL': DateInput.instance.text2,
      'HRINICIAL': TimeInputController.instance.text1,
      'HRFINAL' : TimeInputController.instance.text2,
      'PROJETO' : ProjetoController.instance.projeto,
      'CLIENTE': ClienteController.instance.cliente,
      'NOTA' : NoteController.instance.nota
    });

    return tasks.doc(FirebaseAuth.instance.currentUser?.uid.toString()).set({
      'REGISTROS': list, 
    })
    .then((value){
        Fluttertoast.showToast(
          msg: "Registro inserido com sucesso",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 16.0,
          backgroundColor: Colors.green.shade800,
          webPosition: "center",
          webBgColor: Colors.green.shade800.toString(),);
          
    })
    .catchError((error) => print("Falha ao incluir registro: $error"));
    
    
}

  void saveTask(){

    if(DateInput.instance.text1.isNotEmpty && DateInput.instance.text2.isNotEmpty){

      if(TimeInputController.instance.text1.isNotEmpty && TimeInputController.instance.text2.isNotEmpty){

        if(ProjetoController.instance.projeto.isNotEmpty){

          if(ClienteController.instance.cliente.isNotEmpty){

            final datahorainicial = DateTime(int.parse(DateInput.instance.text1.split('/')[2]),
              int.parse(DateInput.instance.text1.split('/')[1]),
              int.parse(DateInput.instance.text1.split('/')[0]),int.parse(TimeInputController.instance.text1.split(':')[0]), int.parse(TimeInputController.instance.text1.split(':')[1]), 0, 0, 0);
            final datahorafinalizada = DateTime(int.parse(DateInput.instance.text2.split('/')[2]),
              int.parse(DateInput.instance.text2.split('/')[1]),
              int.parse(DateInput.instance.text2.split('/')[0]),int.parse(TimeInputController.instance.text2.split(':')[0]), int.parse(TimeInputController.instance.text2.split(':')[1]), 0, 0, 0);

            if(datahorainicial.compareTo(datahorafinalizada) > 0){
              Fluttertoast.showToast(
                msg: "Horário inicial maior que horário final",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                textColor: Colors.white,
                fontSize: 16.0,
                backgroundColor: Colors.yellow.shade700,
                webPosition: "center",
                webBgColor: Colors.yellow.shade700.toString(),);
            } 
            else{
              addTask();

              DateInput.instance.text1 = ""; 
              DateInput.instance.text2 = "";
              TimeInputController.instance.text1 = "";
              TimeInputController.instance.text2 = "";
              ProjetoController.instance.projeto = "";
              ClienteController.instance.cliente = "";
              NoteController.instance.nota = "";  

              setState((){});

            }

          }
          else{
            Fluttertoast.showToast(
              msg: "Favor inserir um cliente",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              textColor: Colors.white,
              fontSize: 16.0,
              backgroundColor: Colors.yellow.shade700,
              webPosition: "center",
              webBgColor: Colors.yellow.shade700.toString(),);
          }

        }
        else{

          Fluttertoast.showToast(
            msg: "Favor inserir um projeto",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            textColor: Colors.white,
            fontSize: 16.0,
            backgroundColor: Colors.yellow.shade700,
            webPosition: "center",
            webBgColor: Colors.yellow.shade700.toString(),);

        }

      }
      else{

        Fluttertoast.showToast(
          msg: "Favor inserir intervalo de tempo",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 16.0,
          backgroundColor: Colors.yellow.shade700,
          webPosition: "center",
          webBgColor: Colors.yellow.shade700.toString(),);
      }

    }
    else{

      Fluttertoast.showToast(
        msg: "Favor inserir data",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        textColor: Colors.white,
        fontSize: 16.0,
        backgroundColor: Colors.yellow.shade700,
        webPosition: "center",
        webBgColor: Colors.yellow.shade700.toString(),);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: (MediaQuery.of(context).size.width)/8,
        bottom: (MediaQuery.of(context).size.width)/5),
      child: FractionallySizedBox(
        widthFactor: 0.4,
        child: TextButton(
          // ignore: prefer_const_constructors
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
          ),
          // ignore: prefer_const_constructors
          //onPressed: addTask,
          onPressed: saveTask,
          child: const Text(
            'Adicionar',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ClienteInput extends StatefulWidget {
  const ClienteInput({super.key});

  @override
  State<ClienteInput> createState() => _ClienteInputState();
}

class _ClienteInputState extends State<ClienteInput> {

  final TextEditingController clienteinput = TextEditingController(); 

  @override
  void initState() {
    clienteinput.text = ClienteController.instance.cliente; //set the initial value of text field
    super.initState();
    clienteinput.addListener(() {
      final String text = ClienteController.instance.cliente;
      clienteinput.value = clienteinput.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    clienteinput.text = ClienteController.instance.cliente; 

    return 
    Container(
      margin: EdgeInsets.only(top:(MediaQuery.of(context).size.width)/40),
      height: (MediaQuery.of(context).size.width)/5,
      child:  TextField(decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              label: Text('Cliente',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              // onTap:() {
              //     showDialog(
              //     context: context,
              //     builder: (BuildContext context){
              //         return ClienteDialog();
              //     }
              //   );
              // },
              controller: clienteinput,
              onChanged: (text){
                ClienteController.instance.cliente=text;
              },
            )
    );
  }
}

class ProjetoInput extends StatefulWidget {
  const ProjetoInput({super.key});

  @override
  State<ProjetoInput> createState() => _ProjetoInputState();
}

class _ProjetoInputState extends State<ProjetoInput> {
  
  final TextEditingController projetoinput = TextEditingController(); 

  @override
  void initState() {
    projetoinput.text = ProjetoController.instance.projeto; //set the initial value of text field
    super.initState();
    projetoinput.addListener(() {
      final String text = ProjetoController.instance.projeto;
      projetoinput.value = projetoinput.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    projetoinput.text = ProjetoController.instance.projeto;

    return 
    Container(
      height: (MediaQuery.of(context).size.height)/10,
      child: TextField(
        decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              label: Text('Projeto',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              // onTap:() {
              //     showDialog(
              //     context: context,
              //     builder: (BuildContext context){
              //         return ProjetoDialog();
              //     }
              //   );
              // },
              onChanged: (text){
                ProjetoController.instance.projeto=text;},
              controller: projetoinput,
            )
    );
  }

}

class CamposHoras extends StatefulWidget {
  const CamposHoras({super.key});

  @override
  State<CamposHoras> createState() => _CamposHorasState();
}

class _CamposHorasState extends State<CamposHoras> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width)/1.5,
      padding: EdgeInsets.only(bottom:(MediaQuery.of(context).size.height)/200.0,top: 0.0,left: 10.0,right: 10.0),
      child: GridView.count(crossAxisCount: 2,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 0.0,
          children:  [
          Container(
            width: 200.0,
            alignment: Alignment.center,child:const InitDate()),
          Container(
             width: 200.0,
             alignment: Alignment.center,child:const InitTimePicker()),
          Container(
             width: 200.0,
           alignment: Alignment.topCenter,child:const FinalDate()),
          Container(
             width: 200.0,
           alignment: Alignment.topCenter,child:const FinalTimePicker()),
        ]),);
  }
}


class ClienteDialog extends StatefulWidget {
  const ClienteDialog({super.key});

  @override
  State<ClienteDialog> createState() => _ClienteDialogState();
}

class _ClienteDialogState extends State<ClienteDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Clientes'),
      content: Column(
        children: const [Text('Cliente1'),Text('Cliente2'),Text('Cliente3')]
      ),
      actions:  [
        CupertinoDialogAction(onPressed: (){Navigator.pop(context, 'Cancelar');},child: const Text('Cancelar'),),
        CupertinoDialogAction(onPressed: (){Navigator.pop(context, 'Confirmar');},child: const Text('Confirmar'),)
      ],
    );
  }
}

class ProjetoDialog extends StatefulWidget {
  const ProjetoDialog({super.key});

  @override
  State<ProjetoDialog> createState() => _ProjetoDialogState();
}

class _ProjetoDialogState extends State<ProjetoDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Projetos'),
      content: Column(
        children: const [Text('Projeto1'),Text('Projeto2'),Text('Projeto3')]
      ),
      actions:  [
        CupertinoDialogAction(onPressed: (){Navigator.pop(context, 'Cancelar');},child: const Text('Cancelar'),),
        CupertinoDialogAction(onPressed: (){Navigator.pop(context, 'Confirmar');},child: const Text('Confirmar'),)
      ],
    );
  }
}

class NoteController extends ChangeNotifier {
  static NoteController instance = NoteController();
  late String nota="";
}

class ClienteController extends ChangeNotifier {
  static ClienteController instance = ClienteController();
  late String cliente="";
}

class ProjetoController extends ChangeNotifier {
  static ProjetoController instance = ProjetoController();
  late String projeto="";
}

