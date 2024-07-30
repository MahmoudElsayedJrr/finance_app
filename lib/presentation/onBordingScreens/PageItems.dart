import 'package:finance_application/core/ColorsConstants.dart';
import 'package:flutter/material.dart';

class PageItem extends StatelessWidget {
  const PageItem(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.img});
  final String title, subtitle, img;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kPrimaryGreen)),
        SizedBox(height: 10),
        SizedBox(
          width: double.maxFinite,
          height: 200,
          child: Image.asset(img, fit: BoxFit.contain),
        ),
        SizedBox(height: 10),
        Text(subtitle,
            maxLines: 2,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey)),
      ],
    );
  }
}
