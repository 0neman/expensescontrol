import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import '../models/transaction.dart';

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      child: Row(
        children: groupedTransactionValues.map((e) {
          return Text("${e['day']}:${e['amount']}");
        }).toList(),
      ),
    );
  }
}
