import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:learnistan/Main/Authentication/components/login_page.dart';
import 'package:learnistan/Main/ads/ads.dart';
import 'package:learnistan/splash/splash.dart';
import 'package:learnistan/test/fimage.dart';
import 'package:learnistan/Main/Authentication/components/settingPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'Main/Authentication/components/signup_page.dart';
import 'firebase_options.dart';
import 'dart:io';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Admob.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginPage(),
        );
      },
    );
  }
}
