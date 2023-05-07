import 'package:expenses/components/adptive_button.dart';
import 'package:expenses/components/adptive_datepicker.dart';
import 'package:expenses/components/adptive_textfield.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key, this.onSubmit});

  final void Function(String, double, DateTime)? onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  DateTime? selectedDate = DateTime.now();
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    sumbmitForm() {
      final title = titleController.text;
      final value = double.tryParse(valueController.text) ?? 0.0;

      if (title.isEmpty || value <= 0 || selectedDate == null) {
        return;
      }

      widget.onSubmit!(title, value, selectedDate!);
    }


    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
          child: Column(children: [
            AdpativeTextField(
                controller: titleController,
                onSubmitted: (_) {
                  sumbmitForm();
                },
                label: 'Título'),
            AdpativeTextField(
                controller: valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) {
                  sumbmitForm();
                }, 
                label: 'Valor (R\$)'),
            AdptiveDatePicker(selectedDate: selectedDate!, onDateChanged: (newDate){
              setState(() {
                selectedDate =  newDate;
              });
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptiveButton(
                  label: 'Nova Transação',
                  onPressed: () {
                    sumbmitForm();
                  },
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
