import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  // const NewTransaction({super.key});
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (val) {
              //   titleInput = val;
              // },
              controller: titleController,
              onSubmitted: (_) => submitData(), // Annonymous function
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (amt) => amountInput = amt, //for saving input given by user
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            TextButton(
              // onPressed: () {
              //   // print(titleInput);
              //   // print(amountInput);
              //   // print(titleController.text);
              //   // print(amountController.text);
              // },
              onPressed: submitData,
              style: TextButton.styleFrom(
                foregroundColor: Colors.purple,
              ),
              child: Text('Add transaction'),
            )
          ],
        ),
      ),
    );
  }
}
