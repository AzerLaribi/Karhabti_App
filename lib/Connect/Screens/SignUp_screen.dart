// ignore_for_file: unused_field, dead_code

import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:karhabti_app/Connect/Screens/ConnectScreen.dart';
import 'package:karhabti_app/Connect/Screens/SignIn_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:karhabti_app/HomePage/Screens/HomePage_screen.dart';
import '../Providers/Users.dart';

import '../../firebase_options.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _email;
  late final TextEditingController _username;
  late final TextEditingController _password;
  bool _isLoading = false;
  final formGlobalKey = GlobalKey<FormState>();
  @override
  void initState() {
    _email = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _username.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return Scaffold(
      
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Theme.of(context).primaryColor,
          onPressed: () =>
              Navigator.of(context).pushNamed(ConnectScreen.routeName),
        ),
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (_isLoading) {
                return _isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SignInScreen();
              } else {
                return _isLoading
                    ? CircularProgressIndicator()
                    : SingleChildScrollView(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 20.0,
                                        ),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: 60,
                                          child: Column(
                                            children: [
                                              InkWell(
                                                  onTap: () {},
                                                  child: Image.asset(
                                                    'assets/images/logo.png',
                                                    fit: BoxFit.cover,
                                                    height: 45,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          width: 1,
                                          color:
                                              Colors.black), // This is divider
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10.0),
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          height: 75,
                                          child: Column(
                                            children: [
                                              Title(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                child: Text(
                                                  "Welcome",
                                                  style: TextStyle(
                                                      fontFamily: 'Montserrat',
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  'Create a new account',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Montserrat',
                                                    fontSize: 15,
                                                    color: Theme.of(context)
                                                        .accentColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // ignore: deprecated_member_use
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Form(
                                    key: formGlobalKey,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(30),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: _username,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'Enter your User name',
                                                  icon: Icon(
                                                      Icons.account_circle),
                                                ),
                                                keyboardType:
                                                    TextInputType.name,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: _email,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Theme.of(context)
                                                        .accentColor),
                                                decoration: InputDecoration(
                                                  labelText: 'Enter your Email',
                                                  icon: Icon(
                                                      Icons.email_outlined),
                                                ),
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      !value.contains('@')) {
                                                    return 'Invalid email!';
                                                  }
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: _password,
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      122, 136, 162, 0.5),
                                                ),
                                                decoration: InputDecoration(
                                                  iconColor: Color.fromRGBO(
                                                      122, 136, 162, 0.5),
                                                  labelText:
                                                      'Enter your Password',
                                                  icon: Icon(Icons.lock),
                                                ),
                                                obscureText: true,
                                                validator: (value) {
                                                  if (value!.isEmpty ||
                                                      value.length < 5) {
                                                    return 'Password is too short!';
                                                  }
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      122, 136, 162, 0.5),
                                                ),
                                                decoration: InputDecoration(
                                                  iconColor: Color.fromRGBO(
                                                      122, 136, 162, 0.5),
                                                  labelText:
                                                      'Confirm your Password',
                                                  icon: Icon(Icons
                                                      .verified_user_sharp),
                                                ),
                                                obscureText: true,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Empty field';
                                                  } else if (value !=
                                                      _password.text) {
                                                    return 'Inconformed Password';
                                                  }
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 50,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              // ignore: deprecated_member_use
                                              child: RaisedButton(
                                                child: Text('Sign up'),
                                                onPressed: () async {
                                                  final isValid = formGlobalKey
                                                      .currentState!
                                                      .validate();
                                                  if (!isValid) {
                                                    return;
                                                  }

                                                  formGlobalKey.currentState!
                                                      .save();
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  final email = _email.text;
                                                  final password =
                                                      _password.text;
                                                  final userName =
                                                      _username.text;

                                                  final url = Uri.parse(
                                                      'https://test-1dc4e-default-rtdb.firebaseio.com/users.json');

                                                  try {
                                                    final userCredential =
                                                        await FirebaseAuth
                                                            .instance
                                                            .createUserWithEmailAndPassword(
                                                      email: email,
                                                      password: password,
                                                    );
                                                    userCredential.user
                                                        ?.updateDisplayName(
                                                            userName);
                                                    final response = await http
                                                        .post(
                                                      url,
                                                      body: json.encode({
                                                        'id': userCredential
                                                            .user?.uid
                                                            .toString(),
                                                        'name':
                                                            userName.toString(),
                                                        'email': email,
                                                        'password': _password
                                                            .text.hashCode,
                                                        'adress': '',
                                                        'genre': '',
                                                        'FavoritesId': '',
                                                        'naissance':
                                                            DateTime.now()
                                                                .toString(),
                                                        'numTel': '',
                                                        'photoProfilUrl': '',
                                                        'ReviewId': '',
                                                        'vehiculeId': '',
                                                      }),
                                                    )
                                                        .then(
                                                      (_) {
                                                        setState(() {
                                                          _isLoading = false;
                                                        });
                                                        Navigator.of(context)
                                                            .pushNamed(
                                                                SignInScreen
                                                                    .routeName);
                                                      },
                                                    );
                                                    setState(() {
                                                      _isLoading = false;
                                                    });
                                                    print(json
                                                        .encode(response.body));
                                                    print(userCredential);
                                                    print(_email.text);
                                                  } on FirebaseException catch (error) {
                                                    print(error);
                                                    switch (error.code) {
                                                      case 'email-already-in-use':
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
                                                                'Email alredy in use'),
                                                            actions: <Widget>[
                                                              new IconButton(
                                                                  icon: new Icon(
                                                                      Icons
                                                                          .close),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pushNamed(
                                                                            SignUpScreen.routeName);
                                                                  })
                                                            ],
                                                          ),
                                                        );
                                                        break;
                                                    }
                                                  }
                                                },
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                textColor: Theme.of(context)
                                                    .primaryTextTheme
                                                    .button!
                                                    .color,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Alredy have an account ?",
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).accentColor,
                                              fontFamily: 'Montserrat',
                                              fontSize: 12),
                                        ),
                                        FlatButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushNamed(
                                                  SignInScreen.routeName),
                                          child: Text(
                                            'Sign IN',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
              }
              break;
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
