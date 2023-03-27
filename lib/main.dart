import 'dart:math';
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});
  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: const MyHomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme
            .copyWith(primary: Colors.purple, secondary: Colors.amber),
        textTheme: tema.textTheme.copyWith(
          titleLarge: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _trasactions = [];

  List<Transaction> get _recentTransactions {
    return _trasactions.where((element) {
      return element.date
          .isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _trasactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      _trasactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  _opentransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(
            onSubmit: _addTransaction,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontSize: 20 * MediaQuery.of(context).textScaleFactor
        ),
      ),
      actions: [
        IconButton(
            onPressed: () => _opentransactionFormModal(context),
            icon: const Icon(Icons.add))
      ],
    );
    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
                height: availableHeight * 0.3,
                child: Chart(recentTransaction: _recentTransactions)),
            SizedBox(
              height: availableHeight * 0.7,
              child: TransactionList(
                  transactions: _trasactions, onRemove: _removeTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => _opentransactionFormModal(context)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
