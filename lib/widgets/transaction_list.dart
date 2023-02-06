import 'package:expensescontrol/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  const TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (context, Constraints) {
              return Column(children: [
                Text(
                  "no expenses added",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: Constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ]);
            })
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text("DZD ${transactions[index].amount}")),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 300
                        ? TextButton.icon(
                            label: Text("Delete"),
                            icon: Icon(Icons.delete,
                                color: Theme.of(context).primaryColor),
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              deleteTx(transactions[index].id);
                            },
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
