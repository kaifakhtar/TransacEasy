import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../modals/transaction.dart';

class TransactionList extends StatelessWidget {// accept list then make the design

final List<Transaction> transaction ;
final Function _deletetransaction;
 TransactionList(this.transaction, this._deletetransaction); //accept the list

  @override
  Widget build(BuildContext context) {
    return Container(
      height:500 ,
      child: transaction.isEmpty?
          Container(
            height: 200,
            child: Image.asset('assets/images/img_1.png'),
          )
          :ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FittedBox(
                      child: Text(transaction[index].amount.toString())),
                ),
                radius: 30,
                backgroundColor: Theme.of(context).primaryColor,
              ),
              title: Text(transaction[index].title),
              subtitle: Text(DateFormat.yMMMd().format(transaction[index].date)),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => _deletetransaction(transaction[index].id),
              ),
            ),
          );
        },
        itemCount: transaction.length,
      ),
    );
  }
}
