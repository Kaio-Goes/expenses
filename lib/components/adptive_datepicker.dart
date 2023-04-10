import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AdptiveDatePicker extends StatelessWidget {
  const AdptiveDatePicker(
      {super.key, required this.selectedDate, required this.onDateChanged});

  final DateTime selectedDate;
  final Function(DateTime) onDateChanged;

  Future showsDatePicker(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      onDateChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? SizedBox(
          height: 180,
          child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChanged,
            ),
        )
        : SizedBox(
            height: 70,
            child: Row(children: [
              Expanded(
                child: Text(
                  selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}',
                ),
              ),
              TextButton(
                onPressed: () async {
                  await showsDatePicker(context);
                },
                child: const Text(
                  'Selecionar Data!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ]),
          );
  }
}
