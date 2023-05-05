
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {

  RetornaLista listaAtividades = RetornaLista();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
          heightFactor: 1.0,
          widthFactor: 0.9,
          alignment: Alignment.center,
            child: Column(
                  children: <Widget>[
                    ...listaAtividades.preencher()
                  ],
                ),
        );
  }
}


class RetornaLista{

  List<Widget> _widgetOptions = [];

  CollectionReference tasks = FirebaseFirestore.instance.collection('TAREFAS');

  // ignore: non_constant_identifier_names
  List<Widget> preencher(){

      tasks.doc(FirebaseAuth.instance.currentUser?.uid.toString()).get()
            .then((value){
              var reg = value.get("REGISTROS");
              for (var i = 0; i < reg.length; i++) {
                var row = {};
                row = reg[i];
                _widgetOptions.add(Text(row['DTINICIAL']));
              }
            });


      return _widgetOptions;

  }

}

