import 'dart:math';

import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late List<Map<String, Object>> _pages;

  int _selectPageIndex = 0;

  @override
  void initState() {
    _pages = [
      {
        'page': HomePageScreen(),
        'title': 'Home',
      },
      {
        'page': HomePageScreen(),
        'title': 'Notification',
      },
      {
        'page': HomePageScreen(),
        'title': 'Favorites',
      },
      {
        'page': HomePageScreen(),
        'title': 'Seetings',
      },
    ];
    // TODO: implement initState
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8),
              // height: MediaQuery.of(context).size.height * 0.7,
              child: Image.asset(
                'assets/images/logo.png',
                height: 30,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Title(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Hi, User',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      letterSpacing: 2,
                      wordSpacing: 5,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                child: InkWell(
                  onHover: (value) {},
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Stack(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.asset(
                                'assets/images/Car.jpg',
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width * 0.9,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 10,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                color: Colors.black54,
                                padding: EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 20,
                                ),
                                child: Text(
                                  'Add your Car',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontFamily: 'Montserrat'),
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Image.asset(
                                                'assets/images/services/map.png',
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Title(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Text(
                                                    'Find Your \n Service Provider',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Image.asset(
                                                  'assets/images/services/reminder.png',
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Title(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Text(
                                                      'Get Your \n Reminder',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 5,
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Stack(
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 7,
                                              ),
                                              Image.asset(
                                                'assets/images/services/video-tutorial.png',
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Title(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Text(
                                                    'Learn about \n Managing car',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                  child: Column(
                                    children: <Widget>[
                                      Stack(
                                        // ignore: prefer_const_literals_to_create_immutables
                                        children: <Widget>[
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Image.asset(
                                                  'assets/images/services/diagnostic.png',
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Title(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    child: Text(
                                                      'Make a quick \n Diagnostic',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'Montserrat',
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).accentColor,
        selectedItemColor: Theme.of(context).primaryColor,
        currentIndex: _selectPageIndex,
        type: BottomNavigationBarType.shifting,
        // type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.notifications),
            title: Text(
              'Notification',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.favorite),
            title: Text(
              'Favorites',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.settings),
            title: Text(
              'Seetings',
              style: TextStyle(fontFamily: 'Montserrat'),
            ),
          )
        ],
      ),
    );
  }
}
