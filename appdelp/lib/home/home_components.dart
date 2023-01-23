

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import '../dateInput/date.dart';
import '../dateInput/time.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Apontamento de Horas',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  int _selectedIndex = 0;
  static const List<String> titles = <String>["Apontamento de Horas","Histórico de Atividades","DashBoard"];

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    NovaAtividade(),
    Text(
      'Histórico',
      style: optionStyle,
    ),
    Text(
      'DashBoard',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles.elementAt(_selectedIndex)),backgroundColor: Colors.red.shade600,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.new_label_rounded),
            label: 'Atividade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Histórico',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

}

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

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      margin: EdgeInsets.only(top:(MediaQuery.of(context).size.width)/20),
      height: (MediaQuery.of(context).size.height)/10,
      child:const TextField(
              maxLines: 5,
              decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              label: Text('Anotações',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              )
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
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: (MediaQuery.of(context).size.width)/4,
        bottom: (MediaQuery.of(context).size.width)/5),
      child: FractionallySizedBox(
        widthFactor: 0.4,
        child: TextButton(
          // ignore: prefer_const_constructors
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(Colors.red),
          ),
          // ignore: prefer_const_constructors
          onPressed: () {  },
          child: const Text(
            'Adiconar',
            style: const TextStyle(color: Colors.white),
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

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      margin: EdgeInsets.only(top:(MediaQuery.of(context).size.width)/10),
      height: (MediaQuery.of(context).size.width)/5,
      child: TextField(decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              label: Text('Cliente',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onTap:() {
                  showDialog(
                  context: context,
                  builder: (BuildContext context){
                      return ClienteDialog();
                  }
                );
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

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: (MediaQuery.of(context).size.height)/10,
      child: TextField(decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              label: Text('Projeto',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onTap:() {
                  showDialog(
                  context: context,
                  builder: (BuildContext context){
                      return ProjetoDialog();
                  }
                );
              },
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

