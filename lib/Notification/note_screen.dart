import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:karhabti_app/Notification/widgets/chart.dart';
import '../Notification/widgets/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Notification/CostTrack/Models/transaction.dart' as Tr;
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
  var _isInit = true;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late CalendarController _controller;
  final List<Tr.Transaction> _userTransaction = [];
  void initState() {
    Future.delayed(Duration.zero).then((_) {});
    super.initState();
    _controller = CalendarController();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      fetchAndSetProducts().then((_) {});
    }
    _isInit = false;
    super.didChangeDependencies();
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
      await fetchAndSetProducts();
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
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.calendar_today)),
              Tab(icon: Icon(Icons.attach_money)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Title(
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Check your Notifications',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        SizedBox(
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: FloatingActionButton.extended(
                            onPressed: () {},
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
                    child: TableCalendar(
                      calendarStyle: CalendarStyle(),
                      firstDay: kFirstDay,
                      lastDay: kLastDay,
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
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
                  ),
                ],
              ),
            ),
            RefreshIndicator(
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
                            width: MediaQuery.of(context).size.width * 0.6,
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
                              width: MediaQuery.of(context).size.width * 0.3,
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
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: SfCartesianChart(
                              primaryXAxis: DateTimeAxis(),
                              series: <ChartSeries>[
                                // Renders line chart
                                LineSeries<SalesData, DateTime>(
                                    dataSource: chartData,
                                    xValueMapper: (SalesData sales, _) =>
                                        sales.year,
                                    yValueMapper: (SalesData sales, _) =>
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
          ],
        ),
      ),
    );
  }
}
