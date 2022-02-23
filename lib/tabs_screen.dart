// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import '../../../Notification/note_screen.dart';
import './HomePage/Screens/HomePage_screen.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

enum MenuAction {
  Logout,
  EditProfil,
}

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
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
        'page': NoteScreen(),
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
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

    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            _pages[_selectPageIndex]['title'].toString(),
            style: TextStyle(
              fontFamily: 'Montserrat',
              color: Theme.of(context).primaryColor,
            ),
          ),
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
                    Navigator.of(context).pop();

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
        body: _pages[_selectPageIndex]['page'] as Widget,
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
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "We've sent you an email verification Please open it and click on the link to verify you account\n\n if you haven't received a verification email yet, press the button below ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat',
                        ),
                      ),
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
