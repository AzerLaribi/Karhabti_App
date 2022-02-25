// ignore_for_file: dead_code

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:karhabti_app/Notification/widgets/event_list.dart';
import 'package:karhabti_app/Notification/models/events.dart';
import 'package:karhabti_app/Notification/note_tabs_screen.dart';
import '../Notification/widgets/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Notification/CostTrack/Models/transaction.dart' as Tr;
import '../Notification/models/events.dart' as Event;
import '../Notification/CostTrack/Widgets/new_transaction.dart';
import '../Notification/CostTrack/Widgets/transaction_list.dart';
import 'package:http/http.dart' as http;

class NoteScreen extends StatefulWidget {
  static const routeName = '/note';

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

class _NoteScreenState extends State<NoteScreen> {
  late Map<DateTime, List<Events>> selectedEvents = {};
  var _isInit = true;
  TextEditingController _eventController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late CalendarController _controller;
  final List<Tr.Transaction> _userTransaction = [];
  final List<Events> _eventList = [];
  var _isLoading = false;
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      fetchAndSetProducts();
      fetchAndSetEvents();
      getEvents();
    });

    super.initState();
    _controller = CalendarController();
  }

  List<Events> _getEventsFromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {}
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> getEvents() async {
    final url = Uri.parse(
      'https://test-1dc4e-default-rtdb.firebaseio.com/Event/${FirebaseAuth.instance.currentUser?.uid}/Event.json',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        _eventList.add(Events(
          id: prodId,
          title: prodData['title'],
          date: DateTime.parse(prodData['date']),
        ));
      });
      print(extractedData);
      print(_userTransaction);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAndSetEvents() async {
    final List<Events> _loadEvents = [];
    final url = Uri.parse(
      'https://test-1dc4e-default-rtdb.firebaseio.com/Event/${FirebaseAuth.instance.currentUser?.uid}/Event.json',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        selectedEvents[_selectedDay]?.add(
          Events(
            title: prodData['title'],
            date: prodData['date'],
            id: prodId,
          ),
        );
      });
      selectedEvents = _loadEvents as Map<DateTime, List<Events>>;
      print(extractedData);
      print(selectedEvents.values);
    } catch (error) {
      print(error);
    }
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
      'https://test-1dc4e-default-rtdb.firebaseio.com/Transaction/${FirebaseAuth.instance.currentUser?.uid}/transaction.json',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        _userTransaction.add(Tr.Transaction(
          id: prodId,
          title: prodData['title'],
          amount: prodData['amount'],
          date: DateTime.parse(prodData['date']),
        ));
      });
      print(extractedData);
      print(_userTransaction);
    } catch (error) {
      print(error);
    }
  }

  Future<void> _addNewTransaction(
      String title, double amount, DateTime chosenDate) async {
    final url = Uri.parse(
      'https://test-1dc4e-default-rtdb.firebaseio.com/Transaction/${FirebaseAuth.instance.currentUser?.uid}/transaction.json',
    );
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': DateTime.now().toString(),
          'title': title,
          'amount': amount,
          'date': chosenDate.toString(),
        }),
      );

      final newTx = Tr.Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate,
      );
      setState(() {
        _userTransaction.add(newTx);
      });
      print(_userTransaction);
      // _items.insert(0, newProduct); // at the start of the list

    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> _addNewEvent(String title, DateTime chosenDate) async {
    final url = Uri.parse(
      'https://test-1dc4e-default-rtdb.firebaseio.com/Event/${FirebaseAuth.instance.currentUser?.uid}/Event.json',
    );
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': DateTime.now().toString(),
          'title': title,
          'date': chosenDate.toString(),
        }),
      );

      final newEvent = Events(
        id: DateTime.now().toString(),
        title: title,
        date: DateTime.parse(_selectedDay.toString()),
      );
      setState(() {
        if (selectedEvents[_selectedDay] != null) {
          selectedEvents[_selectedDay]?.add(newEvent);
        } else {
          selectedEvents[DateTime.parse(_selectedDay.toString())] = [
            newEvent,
          ];
        }
      });
      print(selectedEvents.values);
      print(newEvent);
      // _items.insert(0, newProduct); // at the start of the list

    } catch (error) {
      print(error);
      throw error;
    }
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  Future<void> _deletTransaction(String id) async {}

  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(DateTime(2017), 28),
      SalesData(DateTime(2018), 20),
      SalesData(DateTime(2019), 17),
      SalesData(DateTime(2020), 35),
      SalesData(DateTime(2021), 40)
    ];
    Future<void> _refreshTransaction(BuildContext context) async {
      setState(() {});
      await fetchAndSetProducts();
    }

    Future<void> _refreshEvents(BuildContext context) async {
      setState(() {
        getEvents();
      });
      await getEvents();
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          toolbarHeight: 2,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            tabs: [
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(
                icon: Icon(Icons.notifications_active),
              ),
              Tab(icon: Icon(Icons.attach_money)),
            ],
          ),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                children: [
                  SingleChildScrollView(
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      onRefresh: () => _refreshEvents(context),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Title(
                                    color: Theme.of(context).primaryColor,
                                    child: Text(
                                      "Check your appoinetement",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  child: FloatingActionButton.extended(
                                    onPressed: () => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Add Note'),
                                        content: TextField(
                                          controller: _eventController,
                                        ),
                                        actions: [
                                          TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.green),
                                            ),
                                            onPressed: () async {
                                              setState(() {
                                                _isLoading = true;
                                              });

                                              if (_eventController
                                                  .text.isEmpty) {
                                                Navigator.of(context).pop();
                                                return;
                                              } else {
                                                try {
                                                  await _addNewEvent(
                                                    _eventController.text,
                                                    DateTime.parse(
                                                      _selectedDay.toString(),
                                                    ),
                                                  ).then((_) => {
                                                        setState(() {
                                                          selectedEvents;
                                                          _isLoading = false;
                                                        })
                                                      });

                                                  Navigator.of(context)
                                                      .pushNamed(NoteTabsScreen
                                                          .routeName);
                                                  return;
                                                } catch (error) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext
                                                            context) =>
                                                        new AlertDialog(
                                                      elevation: 2,
                                                      title: new Text(
                                                        'Warning',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Montserrat'),
                                                      ),
                                                      content: new Text(
                                                          'Select date'),
                                                      actions: <Widget>[
                                                        new IconButton(
                                                            icon: new Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      NoteTabsScreen
                                                                          .routeName);
                                                            })
                                                      ],
                                                    ),
                                                  );

                                                  print('Somthing Wrong');
                                                }
                                              }
                                            },
                                            child: Text(
                                              'Add',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Montserrat'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    label: Text('Add Note'),
                                    icon: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.0),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: Column(
                              children: [
                                TableCalendar(
                                  calendarStyle: CalendarStyle(),
                                  firstDay: kFirstDay,
                                  lastDay: kLastDay,
                                  focusedDay: _focusedDay,
                                  calendarFormat: _calendarFormat,
                                  selectedDayPredicate: (day) {
                                    return isSameDay(_selectedDay, day);
                                  },
                                  eventLoader: _getEventsFromDay,
                                  onDaySelected: (selectedDay, focusedDay) {
                                    if (!isSameDay(_selectedDay, selectedDay)) {
                                      // Call `setState()` when updating the selected day
                                      setState(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay;
                                      });
                                    }
                                  },
                                  onFormatChanged: (format) {
                                    if (_calendarFormat != format) {
                                      // Call `setState()` when updating calendar format
                                      setState(() {
                                        _calendarFormat = format;
                                      });
                                    }
                                  },
                                  onPageChanged: (focusedDay) {
                                    // No need to call `setState()` here
                                    _focusedDay = focusedDay;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      onRefresh: () => _refreshEvents(context),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Title(
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  "Check your appoinetement",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            child: EventList(_eventList, _deletTransaction),
                          )
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: RefreshIndicator(
                      backgroundColor: Colors.white,
                      onRefresh: () => _refreshTransaction(context),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Title(
                                      color: Theme.of(context).primaryColor,
                                      child: Text(
                                        "Track your car'expenses",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Montserrat',
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: FloatingActionButton.extended(
                                        onPressed: () =>
                                            _startAddNewTransaction(context),
                                        label: Text('Add Cost'),
                                        icon: Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: SfCartesianChart(
                                      primaryXAxis: DateTimeAxis(),
                                      series: <ChartSeries>[
                                        // Renders line chart
                                        LineSeries<SalesData, DateTime>(
                                            dataSource: chartData,
                                            xValueMapper:
                                                (SalesData sales, _) =>
                                                    sales.year,
                                            yValueMapper:
                                                (SalesData sales, _) =>
                                                    sales.sales)
                                      ]),
                                ),
                              ),
                              SingleChildScrollView(
                                // height: MediaQuery.of(context).size.height,
                                child: InkWell(
                                  child: TransactionList(
                                      _userTransaction, _deletTransaction),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
