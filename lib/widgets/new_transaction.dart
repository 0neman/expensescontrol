import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleEditController = TextEditingController();

  final _amountEditController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleEditController.text;
    final enteredAmount = double.parse(_amountEditController.text);

    if (enteredTitle.isEmpty ||
        enteredAmount < 0 ||
        _selectedDate == null ||
        _amountEditController.text.isEmpty) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentdatepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now().add(Duration(days: 7)))
        .then((pickedDate) {
      if (pickedDate == null) {
        return _selectedDate = null;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
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
              onSubmitted: (_) => _submitData(),
              decoration: InputDecoration(
                label: Text(
                  "title",
                ),
              ),
              /* onChanged: (value) => titleInput = value,  */
              controller: _titleEditController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              decoration: InputDecoration(
                label: Text("Amount"),
              ),
              /* onChanged: ((value) => amountInput = value),*/
              controller: _amountEditController,
            ),
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "enter a date"
                        : "picked date ${(DateFormat.yMd().format(_selectedDate!))}"),
                  ),
                  TextButton(
                    onPressed: _presentdatepicker,
                    child: Text("add a date"),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _submitData();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.all(10),
                foregroundColor: Theme.of(context).primaryColor,
              ),
              child: Text(
                "Add an expense",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
