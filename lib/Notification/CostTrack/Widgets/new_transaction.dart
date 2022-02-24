// ignore_for_file: avoid_print, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  late DateTime? _selectedDate = null;

  void _SubmitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final entredTitle = _titleController.text;
    final entreAmount = double.parse(_amountController.text);
    if (entredTitle.isEmpty || entreAmount <= 0 || _selectedDate == null) {
      return;
    }
    // ignore: curly_braces_in_flow_control_structures
    widget.addTx(
      entredTitle,
      entreAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _SubmitData,
              controller: _amountController,
              // onChanged: (value) => AmountInput = value,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen'
                        : 'Picked Date : ${DateFormat.yMd().format(_selectedDate!)}',
                  ),
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  height: 70,
                  textColor: Theme.of(context).primaryColor,
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // ignore: deprecated_member_use,
            RaisedButton(
              onPressed: () {
                _SubmitData();
                print('Title : ' + _titleController.text);
                print('Amount : \$' + _amountController.text);
              },
              color: Theme.of(context).primaryColor,
              child: Text('Add Transaction'),
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
