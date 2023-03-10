import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  /*-------------------------------------Attributes-------------------------------------------- */
  final List<Transaction> recentTransactions;
  /*----------------------------------------Constuctor----------------------------------------- */
  Chart(this.recentTransactions);
/*--------------------------------------------Getter------------------------------------------- */
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var sum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          sum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': sum,
      };
    }).toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  label: (e['day'] as String),
                  spendingAmount: e['amount'] as double,
                  spendingPctOfTotal: maxSpending == 0.0
                      ? 0.0
                      : (e['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
