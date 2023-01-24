import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class InitTimePicker extends StatefulWidget {
  const InitTimePicker({super.key});

  @override
  State<InitTimePicker> createState() => _InitTimePickerState();
}

class _InitTimePickerState extends State<InitTimePicker> {

  TextEditingController timeinput = TextEditingController(); 

  @override
  void initState() {
    super.initState();
    timeinput.addListener(() {
      final String text = timeinput.text;
      timeinput.value = timeinput.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
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
                  showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                          confirmText : "Confirmar",
                          cancelText : "Cancelar",
                          errorInvalidText : "Valor Inválido",
                          hourLabelText : "Hora",
                          minuteLabelText : "Minuto",
                          helpText : "Ajuda"
                      ).then((value) {
                        
                        if(value != null ){
                          print(value.format(context));   //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm().parse(value.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime = DateFormat('HH:mm').format(parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.
                          TimeInputController.instance.text1 = formattedTime;
                          setState(() {
                            timeinput.text = formattedTime; //set the value of text field. 
                          });
                        }else{
                            print("Time is not selected");
                        } 

                      });
                  
                
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

  TextEditingController timeinput = TextEditingController(); 

  @override
  void initState() {
    super.initState();
    timeinput.addListener(() {
      final String text = timeinput.text;
      timeinput.value = timeinput.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
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
                  showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                          confirmText : "Confirmar",
                          cancelText : "Cancelar",
                          errorInvalidText : "Valor Inválido",
                          hourLabelText : "Hora",
                          minuteLabelText : "Minuto",
                          helpText : "Ajuda"
                      ).then((value) {
                        
                        if(value != null ){
                          print(value.format(context));   //output 10:51 PM
                          DateTime parsedTime = DateFormat.jm().parse(value.format(context).toString());
                          //converting to DateTime so that we can further format on different pattern.
                          print(parsedTime); //output 1970-01-01 22:53:00.000
                          String formattedTime = DateFormat('HH:mm').format(parsedTime);
                          print(formattedTime); //output 14:59:00
                          //DateFormat() is from intl package, you can format the time on any pattern you need.
                          TimeInputController.instance.text1 = formattedTime;
                          setState(() {
                            timeinput.text = formattedTime; //set the value of text field. 
                          });
                        }else{
                            print("Time is not selected");
                        } 

                      });

                },
             );
  }
}

class TimeInputController extends ChangeNotifier{

  static TimeInputController instance = TimeInputController();

  late String text1;
  late String text2;

}