import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

    Future showsDatePicker() async {
      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2023),
        lastDate: DateTime.now(),
      ).then((value) {
        if (value == null) {
          return;
        }

        setState(() {
          selectedDate = value;
        });
      });
    }

    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            controller: titleController,
            onSubmitted: (_) {
              sumbmitForm();
            },
            decoration: const InputDecoration(
              labelText: 'Título',
            ),
          ),
          TextField(
            controller: valueController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) {
              sumbmitForm();
            },
            decoration: const InputDecoration(
              labelText: 'Valor (R\$)',
            ),
          ),
          SizedBox(
            height: 70,
            child: Row(children: [
              Expanded(
                child: Text(
                  selectedDate == null
                      ? 'Nenhuma data selecionada!'
                      : 'Data selecionada: ${DateFormat('dd/MM/y').format(selectedDate!)}',
                ),
              ),
              TextButton(
                onPressed: () async {
                  await showsDatePicker();
                },
                child: const Text(
                  'Selecionar Data!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: const Text(
                  'Nova Transação',
                ),
                onPressed: () {
                  sumbmitForm();
                },
              ),
            ],
          )
        ]),
      ),
    );
  }
}
