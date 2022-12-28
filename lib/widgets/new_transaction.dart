import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleEditController = TextEditingController();

  final amountEditController = TextEditingController();

  void submitData() {
    final enteredTitle = titleEditController.text;
    final enteredAmount = double.parse(amountEditController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                label: Text(
                  "title",
                ),
              ),
              /* onChanged: (value) => titleInput = value,  */
              controller: titleEditController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
              decoration: InputDecoration(
                label: Text("Amount"),
              ),
              /* onChanged: ((value) => amountInput = value),*/
              controller: amountEditController,
            ),
            TextButton(
              onPressed: () {
                submitData();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(10),
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: Text("Add an expense"),
            ),
          ],
        ),
      ),
    );
  }
}
