import 'package:flutter/material.dart';
import '../../Features/Screen/FeaturesScreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplachScreen extends StatelessWidget {
  static const routeName = '/splach-screen';

  const SplachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: const FeaturesScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/images/logo.png",
      text: "WE CONNECT YOU WITH YOUR CAR",
      textType: TextType.NormalText,
      textStyle: TextStyle(
        fontSize: 15.0,
        color: Theme.of(context).primaryColor,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.white,
    );
  }
}
