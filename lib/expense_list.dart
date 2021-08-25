import 'package:expense_app/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseList extends StatelessWidget {
  final List<Expenses> expenseList;
  final Function deleteExpense;
  ExpenseList(this.expenseList, this.deleteExpense);

  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: expenseList.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("On Expenses"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/empty-cart.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: expenseList.length,
              itemBuilder: (ctx, index) {
                return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('\$${expenseList[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        expenseList[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(expenseList[index].date),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Are You Sure ?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => {
                                  Navigator.pop(context, 'Cancel')
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => this.deleteExpense(expenseList[index].id),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              }),
    );
  }
}
