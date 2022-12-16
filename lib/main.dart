import 'package:flutter/material.dart';
import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          // this is for deprecated accentColor properties.
          accentColor: Colors.amber,
          // colorScheme: ColorScheme.fromSwatch().copyWith(
          //   secondary: Colors.amber,
          // ),
          // This line can be used to eliminated upper both line ..
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
          //     .copyWith(secondary: Colors.amber),
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                  titleMedium: const TextStyle(
                fontFamily: 'Opensans',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          appBarTheme: AppBarTheme(
              // this is for toolbar textStyle.....
              // toolbarTextStyle: ThemeData.light()
              //     .textTheme.copyWith(
              //       titleLarge: const TextStyle(
              //         fontFamily: 'OpenSans',
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ).bodyText2,
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    titleLarge: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .headline6)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 4390.78,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Weekly Groceries',
    //   amount: 893.43,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }
  // List<Transaction> get _recentTransactions {
  //   return _userTransaction
  //       .where((tx) => DateTime.now().difference(tx.date).inDays <= 7)
  //       .toList();
  // }

  void _addNewTransaction(String title, double amount) {
    final txnew = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransaction.add(txnew);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Personal Expenses',
          // style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // this scroll is used to scroll down the whole screen, not some part of screen...
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
