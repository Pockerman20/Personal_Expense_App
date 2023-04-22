import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  // for not allowing user to use app in other orientation, we use these lines.

  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          // this is for deprecated accentColor properties.
          // accentColor: Colors.amber,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.amber,
          ),
          errorColor: Colors.red, // by default error color is red.
          // This line can be used to eliminated upper both line ..
          // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple)
          //     .copyWith(secondary: Colors.amber),
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  fontFamily: 'Opensans',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                labelLarge: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              // this is for toolbar textStyle.....
              // toolbarTextStyle: ThemeData.light()
              //     .textTheme.copyWith(
              //       titleLarge: const TextStyle(
              //         fontFamily: 'OpenSans',
              //         fontSize: 20,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ).bodyMedium,
              titleTextStyle: ThemeData.light()
                  .textTheme
                  .copyWith(
                    titleLarge: const TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                  .titleLarge)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isShowChart = false;
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

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final txnew = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;
    final appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              'Personal Expenses',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                child: Icon(CupertinoIcons.add),
                onTap: () => _startAddNewTransaction(context),
              ),
            ]),
          ) as ObstructingPreferredSizeWidget
        : AppBar(
            title: const Text(
              'Personal Expenses',
              style: TextStyle(fontFamily: 'OpenSans'),
            ),
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          );
    final txListWidget = Container(
      child: TransactionList(_userTransaction, _deleteTransaction),
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        // this scroll is used to scroll down the whole screen, not some part of screen...
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandScape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Switch.adaptive(
                      activeColor: Theme.of(context).colorScheme.secondary,
                      value: _isShowChart,
                      onChanged: (val) {
                        setState(() {
                          _isShowChart = val;
                        });
                      })
                ],
              ),
            if (!isLandScape)
              Container(
                child: Chart(_recentTransactions),
                height: (mediaQuery.size.height -
                        appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.3,
              ),
            if (!isLandScape) txListWidget,
            if (isLandScape)
              _isShowChart
                  ? Container(
                      child: Chart(_recentTransactions),
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                    )
                  : txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
