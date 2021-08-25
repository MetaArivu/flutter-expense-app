import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  final Function addNewExpense;
  NewExpense(this.addNewExpense);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = new TextEditingController();
  final amountController = new TextEditingController();
  late DateTime selectedDate = DateTime.now();

  void addNewExpenseFn() {
    print(selectedDate);
    final title = titleController.text;
    final amt = double.parse(amountController.text);
    if (title.isEmpty || amt <= 0) {
      return;
    }
    widget.addNewExpense(titleController.text, double.parse(amountController.text), selectedDate);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Record Added Successfully')
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addNewExpenseFn,
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child:
                        Text('Date: ${DateFormat.yMd().format(selectedDate)}'),
                  ),
                  FlatButton(
                      onPressed: _presentDatePicker,
                      textColor: Theme.of(context).primaryColor,
                      child: Text('Choose Date'))
                ],
              ),
            ),
            RaisedButton(
              onPressed: addNewExpenseFn,
              child: Text('Add Transaction'),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
