// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class FeaturesScreen extends StatefulWidget {
  static const routeName = '/features-screen';
  const FeaturesScreen({Key? key}) : super(key: key);

  @override
  _FeaturesScreenState createState() => _FeaturesScreenState();
}

class _FeaturesScreenState extends State<FeaturesScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  // redirection to signin/signup
  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/$assetName',
            width: width,
            fit: BoxFit.fitHeight,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 13.0,
      fontFamily: 'Montserrat',
      fontWeight: FontWeight.bold,
    );
    // ignore: unnecessary_const
    var pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 30.0,
        wordSpacing: 5,
        fontWeight: FontWeight.w900,
      ),
      titlePadding: EdgeInsets.only(top: 30),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(45.0, 5.0, 45.0, 20.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Container(color: Colors.white),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.8,
          child: IntroductionScreen(
            key: introKey,
            globalBackgroundColor: Colors.white,
            pages: [
              PageViewModel(
                title: "Karhabti Map",
                body:
                    "Look Through different type of services \n and get your service easly ",
                image: _buildImage('Map.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Karhabti Reminder",
                body:
                    "Add your reminder to be notified of \n important event related to your car",
                image: _buildImage('Note.png'),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Karhabti Diagnostic",
                body: "Perform a health Check quick Diagnostic via smartphone.",
                image: _buildImage(
                  'Diagnostic.png',
                ),
                decoration: pageDecoration,
              ),
              PageViewModel(
                title: "Karhabti Tutorials",
                body: "Learn as you go to made you \n Car maintenance easy",
                image: _buildImage('Tutorial.png'),
                // footer: ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pushNamed(FeaturesScreen.routeName);
                //   },
                //   child: const Text(
                //     'FooButton',
                //     style: TextStyle(color: Colors.white),
                //   ),
                //   style: ElevatedButton.styleFrom(
                //     primary: Theme.of(context).primaryColor,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(8.0),
                //     ),
                //   ),
                // ),
                decoration: pageDecoration,
              ),
            ],
            onDone: () => _onIntroEnd(context),
            //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
            showSkipButton: true,
            skipOrBackFlex: 0,
            nextFlex: 0,
            showBackButton: false,
            //rtl: true, // Display as right-to-left
            back: const Icon(Icons.arrow_back),
            skip: Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color.fromRGBO(36, 54, 95, 1),
              ),
            ),
            next: Icon(
              Icons.arrow_forward,
              color: Color.fromRGBO(36, 54, 95, 1),
            ),
            done: Text(
              'Done',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(36, 54, 95, 1),
              ),
            ),
            curve: Curves.fastLinearToSlowEaseIn,
            controlsMargin: const EdgeInsets.all(16),
            controlsPadding: kIsWeb
                ? const EdgeInsets.all(12.0)
                : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
            dotsDecorator: const DotsDecorator(
              size: Size(10.0, 10.0),
              color: Color(0xFFBDBDBD),
              activeSize: Size(22.0, 10.0),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
            dotsContainerDecorator: const ShapeDecoration(
              // color: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
