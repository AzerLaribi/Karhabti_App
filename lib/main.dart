// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'Features/Screen/FeaturesScreen.dart';
import 'HomeScreen/Screens/splachScreen.dart';
import 'Connect/Screens/ConnectScreen.dart';
import 'Connect/Screens/SignIn_screen.dart';
import 'Connect/Screens/SignUp_screen.dart';
import 'HomePage/Screens/HomePage_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final bool _isloading;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(36, 54, 95, 1),
          accentColor: Color.fromRGBO(122, 136, 162, 1),
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Releway',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(36, 54, 95, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(36, 54, 95, 1),
              ),
              subtitle1: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ))),
      // home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => SplachScreen(),
        '/login/': (context) => SignInScreen(),
        FeaturesScreen.routeName: (context) => FeaturesScreen(),
        ConnectScreen.routeName: (context) => ConnectScreen(),
        SignInScreen.routeName: (context) => SignInScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomePageScreen.routeName: (context) => HomePageScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text(
          'Navigation Time!',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
