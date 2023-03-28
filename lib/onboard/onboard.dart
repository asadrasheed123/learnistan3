import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:learnistan/Main/Authentication/components/login_page.dart';
import 'package:learnistan/Main/Dashboard/dashboard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Onboard extends StatefulWidget {
  const Onboard({Key? key}) : super(key: key);

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> {
  late PageController _pageController;
  late List<Widget> slideList;
  late int initialPage;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    initialPage = _pageController.initialPage;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: GFIntroScreen(
          color: Colors.blueGrey,
          slides: slides(),
          pageController: _pageController,
          currentIndex: initialPage,
          pageCount: 5,
          introScreenBottomNavigationBar: GFIntroScreenBottomNavigationBar(
            pageController: _pageController,
            pageCount: slides().length,
            currentIndex: initialPage,
            onForwardButtonTap: () {
              _pageController.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            },
            onBackButtonTap: () {
              _pageController.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear);
            },
            onDoneTap: () {
              Navigator
                  .of(context)
                  .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
            },
            onSkipTap: () {
              Navigator
                  .of(context)
                  .pushReplacement(MaterialPageRoute(builder: (BuildContext context) => LoginPage()));

            },
            navigationBarColor:  HexColor("#f2f2f2"),
            showDivider: false,
                inactiveColor : Colors.black,
            activeColor: HexColor("#F9A826"),
          ),
        ),
      ),
    );
  }

  List<Widget> slides() {
    return [    Container(   color: Colors.white,
      child: Column(        mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[          Image.asset(            'lib/onboard/second.png',
        width: 200,            height: 200,          ),
        SizedBox(height: 40),
        Text(            'Welcome to Learnistan!',            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),          ),
        SizedBox(height: 20),
        Text(            'We offer a wide range of courses to help you learn new skills and advance your career.',
          textAlign: TextAlign.center,            style: TextStyle(fontSize: 18.sp),          ),        ],
    ),
    ),
      Container(color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/onboard/third.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 40),
            Text(
              'Interactive Learning',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Our courses are designed to be interactive and engaging, with quizzes, exercises and games to help you learn.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp),
            ),
          ],
        ),
      ),
      Container(color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/onboard/four.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 40),
            Text(
              'Expert Instructors',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Our instructors are experts in their fields, with years of experience and a passion for teaching.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp),
            ),
          ],
        ),
      ),
      Container(color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'lib/onboard/first.png',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 40),
            Text(
              'Start Learning Today!',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Sign up now to start learning new skills and advancing your career!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp),
            ),
          ],
        ),
      ),
    ];
  }





}





