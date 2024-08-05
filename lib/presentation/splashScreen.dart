import 'dart:async';

import 'package:finance_application/core/ColorsConstants.dart';
import 'package:finance_application/presentation/HomePage/HomePage.dart';
import 'package:finance_application/presentation/onBordingScreens/onBoardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUsername();
    Timer(Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
              duration: Duration(milliseconds: 1000),
              type: PageTransitionType.fade,
              child: username != null ? HomePage() : OnBoardingScreen()),
          (route) => false);
    });
  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = await prefs.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(46),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/logo-removebg-preview.png'),
          SizedBox(height: 10),
          Text('Finance',
              style: TextStyle(
                  fontSize: 30,
                  color: kPrimaryGreen,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    ));
  }
}
