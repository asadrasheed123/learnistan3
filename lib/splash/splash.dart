import 'package:easy_splash_screen/easy_splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:learnistan/onboard/onboard.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset("lib/splash/SplashLogo.png"),
logoWidth: 150,
      backgroundColor: Colors.white,
      loaderColor: HexColor("#F9A826"),
      showLoader: true,
      navigator: Onboard(),
      durationInSeconds: 5,
    );
  }
}