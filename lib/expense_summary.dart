import 'package:expense_app/expense_chart.dart';
import 'package:expense_app/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseSummary extends StatelessWidget {
  final List<Expenses> expenseList;

  ExpenseSummary(this.expenseList);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < expenseList.length; i++) {
        if (expenseList[i].date.day == weekDay.day &&
            expenseList[i].date.month == weekDay.month &&
            expenseList[i].date.year == weekDay.year) {
          totalSum += expenseList[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

   

  @override
  Widget build(BuildContext context) {

    print(groupedTransactionValues);
    
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
           return Flexible(
              fit: FlexFit.tight,
              child: ExpenseChart(
                data['day'] as String,
                data['amount'] as double,
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
