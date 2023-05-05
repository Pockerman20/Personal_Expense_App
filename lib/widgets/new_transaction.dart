import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/db/db_helper.dart';
import 'package:personal_expense_app/widgets/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({super.key});
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  late DateTime? _selectedDate = null;

  void _submitData() {
    if (_amountController.text.isEmpty) return;

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      DateTime.now().toString(),
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (val) {
                //   titleInput = val;
                // },
                controller: _titleController,
                onSubmitted: (_) => _submitData(), // Annonymous function
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (amt) => amountInput = amt, //for saving input given by user
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                    ),
                    AdaptiveButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              // onPressed: () {
              //   // print(titleInput);
              //   // print(amountInput);
              //   // print(_titleController.text);
              //   // print(_amountController.text);
              // },
              ElevatedButton(
                onPressed: () async {
                  _submitData();
                  await DatabaseHelper.instance.insertRecord({
                    // DatabaseHelper.id: DateTime.now().toString(),
                    DatabaseHelper.id: DateTime.now().toString(),
                    // DatabaseHelper.id: ,
                    DatabaseHelper.name: _titleController.text,
                    DatabaseHelper.price: double.parse(_amountController.text),
                    DatabaseHelper.date: _selectedDate?.toIso8601String()
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor:
                      Theme.of(context).textTheme.titleLarge!.foreground?.color,
                ),
                child: const Text('Add transaction'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
