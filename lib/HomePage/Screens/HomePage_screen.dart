// ignore_for_file: dead_code

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karhabti_app/HomePage/Screens/home_tabs_screen.dart';
import '../../Notification/note_tabs_screen.dart';
import '../../firebase_options.dart';

enum MenuAction {
  Logout,
  EditProfil,
}

class HomePageScreen extends StatefulWidget {
  static const routeName = '/home-page';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  Widget ServiceCard(
    BuildContext context,
    String imageUrl,
    String text,
    Function() tapHandler,
  ) {
    return InkWell(
      onTap: tapHandler,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.47,
        height: MediaQuery.of(context).size.width * 0.4,
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.asset(
                            imageUrl,
                            height: 55,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Title(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              text,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
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
    );
  }

  Future<bool> showLogOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: const Text('Are you sure you want to Log out ?'),
          actions: [
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
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
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text(
                'Log out',
                style: TextStyle(
                  backgroundColor: Colors.red,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print('you are verified');
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Title(
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          'Hi, ${FirebaseAuth.instance.currentUser!.displayName}',
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      child: Image.asset(
                                        'assets/images/Car.jpg',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.25,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        fit: BoxFit.cover,
                                        filterQuality: FilterQuality.high,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      right: 10,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
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
                        height: MediaQuery.of(context).size.height * 0.075,
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  ServiceCard(
                                    context,
                                    'assets/images/services/map.png',
                                    'Find your\n Service Provider',
                                    () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          new AlertDialog(
                                        elevation: 2,
                                        title: new Text(
                                          'SORRY',
                                        ),
                                        content: new Text(
                                            'Karhabti Map Unavailable'),
                                        actions: <Widget>[
                                          new IconButton(
                                              icon: new Icon(Icons.close),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                  ServiceCard(
                                    context,
                                    'assets/images/services/reminder.png',
                                    'Get your \n Reminders',
                                    () {
                                      Navigator.of(context)
                                          .pushNamed(NoteTabsScreen.routeName);
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  ServiceCard(
                                    context,
                                    'assets/images/services/video-tutorial.png',
                                    'Learn about\n Managing your car',
                                    () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          new AlertDialog(
                                        elevation: 2,
                                        title: new Text(
                                          'SORRY',
                                        ),
                                        content: new Text(
                                          'Karhabti Tutorial Unavailable',
                                        ),
                                        actions: <Widget>[
                                          new IconButton(
                                              icon: new Icon(Icons.close),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                  ServiceCard(
                                    context,
                                    'assets/images/services/diagnostic.png',
                                    'Make a quick\n Diagnostic',
                                    () => showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          new AlertDialog(
                                        elevation: 2,
                                        title: new Text(
                                          'SORRY',
                                        ),
                                        content: new Text(
                                            'Karhabti Diagnostic Unavailable'),
                                        actions: <Widget>[
                                          new IconButton(
                                              icon: new Icon(Icons.close),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              })
                                        ],
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
              );
              break;
            default:
              return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
