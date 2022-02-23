// ignore_for_file: dead_code

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../firebase_options.dart';
import 'dart:developer' as devtools;

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
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
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
            PopupMenuButton<MenuAction>(
              onSelected: (value) async {
                switch (value) {
                  case MenuAction.Logout:
                    final logout = await showLogOutDialog(context);
                    if (logout) {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/login/', (_) => false);
                    }
                    break;
                  case MenuAction.EditProfil:
                    // TODO: Handle this case.
                    break;
                }
              },
              icon: Icon(
                Icons.account_circle,
                color: Theme.of(context).primaryColor,
              ),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Edit profil',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  value: MenuAction.EditProfil,
                ),
                PopupMenuItem(
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Theme.of(context).accentColor,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ],
                  ),
                  value: MenuAction.Logout,
                ),
              ],
            ),
          ],
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Image.asset(
                                          'assets/images/Car.jpg',
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.high,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 10,
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
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
                                      () {
                                        Navigator.of(context).pushNamed(
                                            HomePageScreen.routeName);
                                      },
                                    ),
                                    ServiceCard(
                                      context,
                                      'assets/images/services/reminder.png',
                                      'Get your \n Reminders',
                                      () {
                                        Navigator.of(context).pushNamed(
                                            HomePageScreen.routeName);
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
                                          content: new Text('Unavailable'),
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
                                          content: new Text('Unavailable'),
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
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Theme.of(context).primaryColor,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              Column(
                children: [
                  Text(
                    'Please verify your email address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () async {
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();
                        print(FirebaseAuth.instance.currentUser?.email);
                        Timer(
                          Duration(seconds: 7),
                          () => Navigator.of(context).pop(),
                        );
                      },
                      child: Text('Send email verification'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }
}
