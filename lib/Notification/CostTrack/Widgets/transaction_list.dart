// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(this.transactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //ListView.builder() methode
      child: transactions.isEmpty
          ? Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text(
                  'No Transaction added',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            '\$ ${transactions[index].amount}',
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat().format(transactions[index].date),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () => showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Delete Transaction'),
                            content: const Text(
                                'Are you sure you want to delete this transaction ?'),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    backgroundColor: Colors.green,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.red),
                                ),
                                onPressed: () {
                                  deleteTx(transactions[index].id);
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    backgroundColor: Colors.red,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
                // return Card(
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                //         decoration: BoxDecoration(
                //             border: Border.all(
                //           color: Theme.of(context).primaryColor,
                //           width: 2,
                //         )),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                //           // ignore: prefer_const_constructors
                //           style: TextStyle(
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20,
                //             color: Theme.of(context).primaryColor,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: <Widget>[
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context).textTheme.subtitle1,
                //           ),
                //           Text(
                //             DateFormat().format(transactions[index].date),
                //             style: TextStyle(
                //               fontSize: 14,
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );
              },
              itemCount: transactions.length,
            ),
      //List View children method
      // child: ListView(
      //   children: transactions.map((tx) {
      //     return Card(
      //       child: Row(
      //         children: <Widget>[
      //           Container(
      //             margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      //             decoration: BoxDecoration(
      //                 border: Border.all(
      //               color: Colors.purple,
      //               width: 2,
      //             )),
      //             padding: EdgeInsets.all(10),
      //             child: Text(
      //               '\$ ${tx.amount}',
      //               // ignore: prefer_const_constructors
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold,
      //                   fontSize: 20,
      //                   color: Colors.purple),
      //             ),
      //           ),
      //           Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Text(
      //                 tx.title,
      //                 style: TextStyle(
      //                   fontSize: 16,
      //                   fontWeight: FontWeight.bold,
      //                 ),
      //               ),
      //               Text(
      //                 DateFormat().format(tx.date),
      //                 style: TextStyle(
      //                   fontSize: 14,
      //                   color: Colors.grey,
      //                 ),
      //               ),
      //             ],
      //           )
      //         ],
      //       ),
      //     );
      //   }).toList(),
    );
  }
}
