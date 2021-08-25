import 'package:expense_app/expense_list.dart';
import 'package:expense_app/expense_summary.dart';
import 'package:expense_app/expenses.dart';
import 'package:expense_app/new_expense.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<Expenses> expenseList;

  HomePage(this.expenseList);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Expenses> expenseList = [
  ];

  void _addExpense(String title, double amount, DateTime dateTime) {
    setState(() {
      expenseList.add(new Expenses(
          DateTime.now().toString(), title, amount, dateTime));
    });
  }

  void _showAddNewExpense(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(onTap: (){}, child: NewExpense(_addExpense) , behavior: HitTestBehavior.opaque,);
        });
  }

  void _deleteExpense(String id){
    print(id);
     setState(() {
       expenseList.removeWhere((element) => element.id == id);
     });
    Navigator.pop(context, 'Cancel');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Record Deleted Successfully'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Code to execute.
          },
        ),
      ),
    );
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Application"),
        actions: [
          IconButton(
              onPressed: () => _showAddNewExpense(context),
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ExpenseSummary(expenseList),
          ExpenseList(expenseList, _deleteExpense)
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNewExpense(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
