// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:karhabti_app/Notification/models/events.dart';
import '../CostTrack/Models/transaction.dart';
import 'package:intl/intl.dart';

class EventList extends StatelessWidget {
  final List<Events> events;
  final Function deleteTx;
  EventList(this.events, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      //ListView.builder() methode
      child: events.isEmpty
          ? Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text(
                  'No Event added',
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
                        child:
                            FittedBox(child: Icon(Icons.lock_clock_outlined)),
                      ),
                    ),
                    title: Text(
                      events[index].title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat().format(events[index].date),
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
                                  deleteTx(events[index].id);
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
              },
              itemCount: events.length,
            ),
    );
  }
}
