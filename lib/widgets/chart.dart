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
        if (recentTransactions[i].date.day == DateTime.now().day &&
            recentTransactions[i].date.month == DateTime.now().month &&
            recentTransactions[i].date.year == DateTime.now().year) {
          sum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(sum);
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': sum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10),
      child: Row(
        children: groupedTransactionValues.map((e) {
          return Text("${e['amount']}:${e['day']}");
        }).toList(),
      ),
    );
  }
}
