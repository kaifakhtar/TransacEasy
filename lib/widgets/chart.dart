import 'package:flutter/material.dart';
import '../modals/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {


  List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  List<Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index) {

      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalSum=0.0;

      for(var i=0;i<recentTransaction.length;i++){

        if(recentTransaction[i].date.day==weekday.day
            && recentTransaction[i].date.month==weekday.month
               &&recentTransaction[i].date.year==weekday.year)
        {
                  totalSum+=recentTransaction[i].amount;

        }
      }
      return {'day':DateFormat.E().format(weekday).substring(0,1), 'amount' : totalSum};
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Container(
      height: 150,
      child: Card(
        elevation: 6,
        child: Row(
          children:
                groupedTransactionValues.map((data){
                  return Text('${data['day']}: ${data['amount']}');
      }).toList()
        ),
      ),
    );
  }
}
