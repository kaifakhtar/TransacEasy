import 'package:flutter/material.dart';
import 'package:transaction_app_udemy/widgets/chart.dart';
import 'package:transaction_app_udemy/widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './modals/transaction.dart';
void main() {
  runApp(MaterialApp(
    home: TransacEasy(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.purple[200]
    ),
  ));
}

class TransacEasy extends StatefulWidget {
  @override
  State<TransacEasy> createState() => _TransacEasyState();
}

class _TransacEasyState extends State<TransacEasy> {

  final List<Transaction> _userTransactions = [
    // Transaction(id: "t1", title: "Fruits", amount: 20.05, date: DateTime.now()),
    // Transaction(id: "t2 ", title: "dettol", amount: 60.87, date: DateTime.now()),
  ];


  List<Transaction> get _recentTransactions{
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount){
    final newTx =Transaction(           // triggers after add trans. button and create Transaction object
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now()
    );

    setState((){              // runs the build method of this class
      _userTransactions.add(newTx);// add new transaction to the list
    });
  }

   void _startNewTransaction(BuildContext ctx){
     showModalBottomSheet(
       enableDrag: true,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),topRight: Radius.circular(30.0))
       ),
         context: ctx,
         builder: (_){
       return NewTransaction(_addNewTransaction);
     });
   }
   void _deleteTransaction(String id){
    setState((){
      _userTransactions.removeWhere((tx) => tx.id==id);
    });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TransacEasy"),
          actions: [
            IconButton(
              onPressed: ()=>_startNewTransaction(context),
                icon: Icon(Icons.add))],
        ),
        body: SingleChildScrollView(

            child: Column(
              children: [
                Chart(_recentTransactions),
                TransactionList(_userTransactions,_deleteTransaction),
              ],
            ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: ()=>_startNewTransaction(context),
          child: Icon(Icons.monetization_on),
        ),
      drawer: Drawer(),
    );
  }
}
