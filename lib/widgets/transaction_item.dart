import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense_app/db/db_helper.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.transactions,
    required this.deleteTx,
  });

  final Transactions transactions;
  final Function deleteTx;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  late Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.blue,
      Colors.black,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          // leading: Container(
          //   height: 60,
          //   width: 60,
          //   decoration: BoxDecoration(
          //       color: Colors.amber, shape: BoxShape.circle),
          //   // :point-up: is used to make circleAvatar by using container by yourself.
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
                //for writing rupees sign use: press CNTL+SHIFT+ (and type) u20b9 and then release.
                child:
                    Text('₹${widget.transactions.amount.toStringAsFixed(2)}')),
          ),
        ),
        title: Text(
          widget.transactions.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transactions.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () async {
                  widget.deleteTx(widget.transactions.id);
                  await DatabaseHelper.instance
                      .deleteRecord(widget.transactions.id);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
              )
            : IconButton(
                onPressed: () async {
                  widget.deleteTx(widget.transactions.id);
                  await DatabaseHelper.instance
                      .deleteRecord(widget.transactions.id);
                },
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
              ),
      ),
    );
  }
}
