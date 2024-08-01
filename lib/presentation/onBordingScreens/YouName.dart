import 'package:finance_application/core/ColorsConstants.dart';
import 'package:finance_application/presentation/HomePage/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class YourNameScreen extends StatelessWidget {
  const YourNameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
                height: 200,
                child: Image.asset('assets/images/logo-removebg-preview.png')),
            Spacer(),
            Text(
              'Enter the name you want to appear',
              //textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 8),
                isDense: true,
                labelStyle: TextStyle(color: KBlackColor),
                focusColor: kPrimaryGreen,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kPrimaryGreen, width: 2.0),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryGreen, width: 2.0),
                    borderRadius: BorderRadius.circular(4),
                    gapPadding: 2.0),
                hintMaxLines: 1,
                labelText: 'Name',
                prefixIcon: Icon(Icons.person_rounded),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                if (nameController.text.isNotEmpty) {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.setString('name', nameController.text);
                  await prefs.setBool('onbordedone', true);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                }
              },
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: kSeconderyGreen),
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryGreen),
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    )));
  }
}
