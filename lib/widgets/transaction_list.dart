import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart'; // .. -> says to go up by one step in folder and then search the file
// import './user_transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    // return Column(
    // return Container(    // this scroll is used to scroll only the list in the app not the whole screen...
    //   height: 300,
    // child: SingleChildScrollView(
    // child: Column(
    return Container(
      // this scroll is used to scroll only the list in the app not the whole screen...
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  // used to separate amount from border by 10 unit space
                  child: Text(
                    // tx.amount.toString(),
                    // '\$ ${tx.amount}',  //print amount in US Dollars
                    '₹ ${transactions[index].amount.toStringAsFixed(2)}', // print amount in Indian Rupees
                    // $(in dart) is used for string interpolation
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        fontSize: 20,
                        color: Colors.purple),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      transactions[index].title,
                      // textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      // tx.date.toString(), //print date without any modification i.e (November 9,2022 06:45:16.345343)
                      // DateFormat().format(tx.date),  // print date and time i.e (November 9,2022 06:45:13 AM)
                      DateFormat.yMMMEd().format(transactions[index].date),
                      // textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                        // fontSize: 15 ,
                        fontStyle: FontStyle.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
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
