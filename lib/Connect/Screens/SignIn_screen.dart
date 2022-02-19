import 'package:flutter/material.dart';
import 'package:karhabti_app/Connect/Screens/ConnectScreen.dart';
import 'package:karhabti_app/Connect/Screens/SignUp_screen.dart';
import 'package:karhabti_app/HomePage/Screens/HomePage_screen.dart';

class SignInScreen extends StatelessWidget {
  static const routeName = '/signIn-screen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
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
                          width: MediaQuery.of(context).size.width * 0.2,
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
                          width: 1, color: Colors.black), // This is divider
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 75,
                          child: Column(
                            children: [
                              Title(
                                color: Theme.of(context).primaryColor,
                                child: Text(
                                  "Welcome",
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Sign in to continue',
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ignore: deprecated_member_use
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Form(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(context).accentColor),
                                decoration: InputDecoration(
                                  labelText: 'Enter your Email',
                                  icon: Icon(Icons.email_outlined),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) {
                                  if (value!.isEmpty || !value.contains('@')) {
                                    return 'Invalid email!';
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(122, 136, 162, 0.5),
                                ),
                                decoration: InputDecoration(
                                  iconColor: Color.fromRGBO(122, 136, 162, 0.5),
                                  labelText: 'Enter your Password',
                                  icon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty || value.length < 5) {
                                    return 'Password is too short!';
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: RaisedButton(
                                child: Text('LOGIN'),
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(HomePageScreen.routeName),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: Theme.of(context).primaryColor,
                                textColor: Theme.of(context)
                                    .primaryTextTheme
                                    .button!
                                    .color,
                              ),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot your Password ?',
                                style: TextStyle(
                                    color: Theme.of(context).accentColor,
                                    fontFamily: 'Montserrat',
                                    fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 0,
                    indent: 35,
                    endIndent: 35,
                    thickness: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Title(
                    color: Theme.of(context).primaryColor,
                    child: Text('You can connect with',
                        style:
                            TextStyle(fontFamily: 'Montserrat', fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 50.0,
                            ),
                            child: SizedBox(
                              width: 75,
                              height: 60,
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      child: Image.asset(
                                        'assets/images/facebook.png',
                                        fit: BoxFit.cover,
                                        height: 45,
                                      ))
                                ],
                              ),
                            ),
                          ), // This is divider

                          Padding(
                            padding: const EdgeInsets.only(left: 50.0),
                            child: SizedBox(
                              width: 75,
                              height: 60,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Image.asset(
                                      'assets/images/gmail.png',
                                      fit: BoxFit.cover,
                                      height: 45,
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
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have any account ?",
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontFamily: 'Montserrat',
                              fontSize: 12),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed(SignUpScreen.routeName),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Theme.of(context).accentColor,
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
      ),
    );
  }
}
