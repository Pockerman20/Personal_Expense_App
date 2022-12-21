import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart'; // .. -> says to go up by one step in folder and then search the file
// import './user_transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

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
          ? Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/31.1 fonts/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      // leading: Container(
                      //   height: 60,
                      //   width: 60,
                      //   decoration: BoxDecoration(
                      //       color: Colors.amber, shape: BoxShape.circle),
                      //   // :point-up: is used to make circleAvatar by using container by yourself.
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            //for writing rupees sign use: press CNTL+SHIFT+ (and type) u20b9 and then release.
                            child: Text(
                                '₹${transactions[index].amount.toStringAsFixed(2)}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      onPressed: () => deleteTx(transactions[index].id),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
      // ),
      // ),
    );
  }
}
