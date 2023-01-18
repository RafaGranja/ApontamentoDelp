

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InitDate extends StatefulWidget {
  const InitDate({super.key});

  @override
  State<InitDate> createState() => _InitDateState();
}

class _InitDateState extends State<InitDate> {

  final TextEditingController datecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    datecontroller.addListener(() {
      final String text = datecontroller.text;
      datecontroller.value = datecontroller.value.copyWith(
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
                  controller: datecontroller,
              //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Data Inicial" //label text of field
                  ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100),
                    helpText: "Ajuda",
                    cancelText: "Cancelar",
                    confirmText: "Confirmar",
                    errorInvalidText : "Valor Inválido",
                    errorFormatText: "Valor inválido",
                    fieldHintText: "Data Inicial",
                    fieldLabelText: "Data Inicial",
                    );
 
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    DateInput.instance.text1 =
                        formattedDate;
                        datecontroller.text=formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            );
  }
}

class FinalDate extends StatefulWidget {
  const FinalDate({super.key});

  @override
  State<FinalDate> createState() => _FinalDateState();
}

class _FinalDateState extends State<FinalDate> {

  final TextEditingController datecontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    datecontroller.addListener(() {
      final String text = datecontroller.text;
      datecontroller.value = datecontroller.value.copyWith(
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
                  controller: datecontroller,
              //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Data Final" //label text of field
                  ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2100),
                    helpText: "Ajuda",
                    cancelText: "Cancelar",
                    confirmText: "Confirmar",
                    errorInvalidText : "Valor Inválido",
                    fieldHintText: "Data Final",
                    fieldLabelText: "Data Final",
                    );
 
                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('dd/MM/yyyy').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    DateInput.instance.text2 =
                        formattedDate;
                        datecontroller.text=formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            );
  }
}

class DateInput extends ChangeNotifier{

  static DateInput instance = DateInput();

  late String text1;
  late String text2;
  
}