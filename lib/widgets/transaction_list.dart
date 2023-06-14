import 'package:flutter/material.dart';
import 'package:personal_expense_app/widgets/transaction_item.dart';

import '../models/transaction.dart'; // .. -> says to go up by one step in folder and then search the file
// import './user_transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTx;

  const TransactionList(this.transactions, this.deleteTx, {super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(
    // return Container(    // this scroll is used to scroll only the list in the app not the whole screen...
    //   height: 300,
    // child: SingleChildScrollView(
    // child: Column(
    return Container(
      // this scroll is used to scroll only the list in the app not the whole screen...
      height: 450,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    // height: 200,
                    child: Image.asset(
                      'assets/31.1 fonts/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          // : ListView.builder(
          //     itemBuilder: (ctx, index) {
          //       return TransactionItem(
          //           transactions: transactions[index], deleteTx: deleteTx);
          //     },
          //     itemCount: transactions.length,
          //   ),
          : ListView(
              children: transactions
                  .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        transactions: tx,
                        deleteTx: deleteTx,
                      ))
                  .toList()),
    );
  }
}
