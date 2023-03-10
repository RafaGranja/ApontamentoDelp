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
    // timeinput.addListener(() {
    //   final String text = timeinput.text;
    //   timeinput.value = timeinput.value.copyWith(
    //     text: text,
    //     selection:
    //         TextSelection(baseOffset: text.length, extentOffset: text.length),
    //     composing: TextRange.empty,
    //   );
    // });
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
                      //output 10:51 PM
                      // ignore: use_build_context_synchronously
                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      //output 1970-01-01 22:53:00.000
                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                      //output 14:59
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        TimeInputController.instance.text1 = formattedTime;
                        timeinput.text = formattedTime; //set the value of text field. 
                      });
                  }else{
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

  final TextEditingController timeinput2 = TextEditingController(); 


  @override
  void initState() {
    timeinput2.text = TimeInputController.instance.text2; //set the initial value of text field
    super.initState();
    // timeinput2.addListener(() {
    //   final String text = timeinput2.text;
    //   timeinput2.value = timeinput2.value.copyWith(
    //     text: text,
    //     selection:
    //         TextSelection(baseOffset: text.length, extentOffset: text.length),
    //     composing: TextRange.empty,
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
                controller: timeinput2, //editing controller of this TextField
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
                      //output 10:51 PM
                      // ignore: use_build_context_synchronously
                      DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                      //converting to DateTime so that we can further format on different pattern.
                      //output 1970-01-01 22:53:00.000
                      String formattedTime = DateFormat('HH:mm').format(parsedTime);
                      //output 14:59
                      //DateFormat() is from intl package, you can format the time on any pattern you need.

                      setState(() {
                        TimeInputController.instance.text2 = formattedTime;
                        timeinput2.text = formattedTime; //set the value of text field. 
                      });
                  }else{
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