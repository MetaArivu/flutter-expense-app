import 'package:expense_app/expenses.dart';
import 'package:expense_app/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<Expenses> expenseList = [
    Expenses("e1", "Nike Shoes", 20000, DateTime.now()),
    Expenses("e2", "Bose Music Systeem", 50000, DateTime.now()),
    Expenses("e3", "IPhone 12", 70000, DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(this.expenseList),
      theme: ThemeData(

          textTheme: ThemeData.light()
                     .textTheme
                     .copyWith(
                       title: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.bold),
                       button: TextStyle(fontFamily: 'OpenSans'),
                      ),
          
          appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold))),

          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand'),

    );
  }
}
