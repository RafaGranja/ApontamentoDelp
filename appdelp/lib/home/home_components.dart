

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
    return Container(
      margin: const EdgeInsets.only(left:200.0,right: 200.0),
      child: Center(
        child: GridView.count(crossAxisCount: 2,crossAxisSpacing: 50.0,mainAxisSpacing: 0.0,
          children:  [
          Container(alignment: Alignment.center,child:const InitDate()),
           Container(alignment: Alignment.center,child:const InitTimePicker()),
           Container(alignment: Alignment.topCenter,child:const FinalDate()),
           Container(alignment: Alignment.topCenter,child:const InitTimePicker()),
          ],)
        
        )
    );
  }
}

