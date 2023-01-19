

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
      heightFactor: 1.1,
      widthFactor: 0.9,
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
              maxLines: 4,
              decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
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
      child:const TextField(decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              label: Text('Cliente',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              )
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
      child:const TextField(decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              label: Text('Projeto',textScaleFactor: 1.4,),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              )
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
    return SizedBox.square(
      dimension: (MediaQuery.of(context).size.width)/1.6,
      child: GridView.count(crossAxisCount: 2,crossAxisSpacing: 20.0,mainAxisSpacing: 0.0,
          children:  [
          Container(alignment: Alignment.center,child:const InitDate()),
          Container(alignment: Alignment.center,child:const InitTimePicker()),
          Container(alignment: Alignment.topCenter,child:const FinalDate()),
          Container(alignment: Alignment.topCenter,child:const FinalTimePicker()),
        ]),);
  }
}

