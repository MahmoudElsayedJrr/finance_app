import 'package:finance_application/core/ColorsConstants.dart';
import 'package:finance_application/presentation/onBordingScreens/PageItems.dart';
import 'package:finance_application/presentation/onBordingScreens/YouName.dart';
import 'package:finance_application/presentation/onBordingScreens/dotIndicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int currentIndex = 0;
  PageController _pageController = PageController();
  List<PageItem> items = [
    PageItem(
        title: 'Welcome',
        subtitle:
            'Welcome to Finance - Your Personal Finance Companion, Simplify your financial life with powerful tools and insights, Get started on your journey to financial freedom today!',
        img: 'assets/images/finance1.png'),
    PageItem(
        title: 'Track Expenses',
        subtitle:
            'Easily track all your expenses in one place, Stay on top of your spending with real-time updates, Gain insights into your spending habits and make informed decisions.',
        img: 'assets/images/finance2.png'),
    PageItem(
        title: 'Get Started',
        subtitle:
            'Ready to take control of your finances?, Sign up now and start your journey to financial wellness, Join thousands of satisfied users and transform your financial future.',
        img: 'assets/images/finance3.png'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(height: 10),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => YourNameScreen()),
                    );
                  },
                  child: Text('Skip',
                      style: TextStyle(
                          fontSize: 18, color: Colors.blue.shade900))),
            ),
            Spacer(),
            SizedBox(
              height: 350,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemCount: items.length,
                controller: _pageController,
                itemBuilder: (context, index) => items[index],
              ),
            ),
            Spacer(),
            dotsIndicator(currentIndex: currentIndex),
            Spacer(),
            InkWell(
              onTap: () {
                if (currentIndex == items.length - 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => YourNameScreen()),
                  );
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                decoration: BoxDecoration(
                  color: currentIndex == items.length - 1
                      ? kPrimaryGreen
                      : kSeconderyGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "Let's Started",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: KWhiteColor),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      )),
    );
  }
}
