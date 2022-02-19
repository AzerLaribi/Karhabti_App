// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../Connect/Screens/SignIn_screen.dart';
import '../../Connect/Screens/SignUp_screen.dart';

class ConnectScreen extends StatelessWidget {
  static const routeName = '/connect-screen';
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
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
                Title(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Hello",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 30,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Best Place to manage your car \n and enjoy your drive',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
            // ignore: deprecated_member_use
            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: RaisedButton(
                    elevation: 5,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(SignInScreen.routeName),
                    color: Theme.of(context).primaryColor,
                    child: Text('Sign In'),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: RaisedButton(
                    elevation: 5,
                    onPressed: () =>
                        Navigator.of(context).pushNamed(SignUpScreen.routeName),
                    color: Theme.of(context).accentColor,
                    child: Text('Sign Up'),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
