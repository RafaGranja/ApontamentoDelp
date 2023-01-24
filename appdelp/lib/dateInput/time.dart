import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class InitTimePicker extends StatefulWidget {
  const InitTimePicker({super.key});

  @override
  State<InitTimePicker> createState() => _InitTimePickerState();
}

class _InitTimePickerState extends State<InitTimePicker> {

  final TextEditingController timeinput = TextEditingController(); 

  @override
  void initState() {
    timeinput.text = TimeInputController.instance.text1; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
                controller: timeinput, //editing controller of this TextField
                decoration: const InputDecoration( 
                   icon: Icon(Icons.timer), //icon of text field
                   labelText: "Hora Inicial" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  TimeOfDay? pickedTime =  await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                          confirmText : "Confirmar",
                          cancelText : "Cancelar",
                          errorInvalidText : "Valor Inválido",
                          hourLabelText : "Hora",
                          minuteLabelText : "Minuto",
                          helpText : "Ajuda"
                      );
                  
                  if(pickedTime != null ){
                      print(pickedTime.format(context));   //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        TimeInputController.instance.text1 = formattedTime;
                        timeinput.text = formattedTime; //set the value of text field. 
                      });
                  }else{
                      print("Time is not selected");
                  }
                
                },
             );
  }
}

class FinalTimePicker extends StatefulWidget {
  const FinalTimePicker({super.key});

  @override
  State<FinalTimePicker> createState() => _FinalTimePickerState();
}

class _FinalTimePickerState extends State<FinalTimePicker> {

  final TextEditingController timeinput = TextEditingController(); 


  @override
  void initState() {
    timeinput.text = TimeInputController.instance.text2; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
                controller: timeinput, //editing controller of this TextField
                decoration: const InputDecoration( 
                   icon: Icon(Icons.timer), //icon of text field
                   labelText: "Hora Final" //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                          TimeOfDay? pickedTime =  await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                          confirmText : "Confirmar",
                          cancelText : "Cancelar",
                          errorInvalidText : "Valor Inválido",
                          hourLabelText : "Hora",
                          minuteLabelText : "Minuto",
                          helpText : "Ajuda"
                      );
                  
                  if(pickedTime != null ){
                      print(pickedTime.format(context));   //output 10:51 PM
                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      print(parsedTime); //output 1970-01-01 22:53:00.000
                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                      print(formattedTime); //output 14:59:00
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        TimeInputController.instance.text2 = formattedTime;
                        timeinput.text = formattedTime; //set the value of text field. 
                      });
                  }else{
                      print("Time is not selected");
                  }
                },
             );
  }
}

class TimeInputController extends ChangeNotifier{

  static TimeInputController instance = TimeInputController();

  late String text1="";
  late String text2="";

}