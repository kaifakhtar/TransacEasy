import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
 final Function addTxButtonHandler;


  NewTransaction(this.addTxButtonHandler);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  onSubmit(){
    final enterTitle = titleController.text;
    final enterAmount = double.parse(amountController.text);

    if(enterTitle.isEmpty || enterAmount<=0) return;

    widget.addTxButtonHandler(enterTitle, enterAmount);
    Navigator.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(label: Text("Title")),
          ),
          SizedBox(height: 20.0,),
          TextField(
            controller: amountController,
            decoration: InputDecoration(label: Text("Amount")),
            keyboardType: TextInputType.number,
            onSubmitted: (_)=>onSubmit(),
          ),
          SizedBox(height: 40.0,),
          ElevatedButton(
            onPressed: onSubmit,
            child: Text("Add"),
            style: ElevatedButton.styleFrom(primary: Colors.purple),
          )
        ],
      ),
    );
  }
}
