import 'package:finance_application/core/ColorsConstants.dart';
import 'package:flutter/material.dart';

class dotsIndicator extends StatelessWidget {
  const dotsIndicator({
    super.key,
    required this.currentIndex,
  });

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (index) => Container(
                margin: EdgeInsets.only(left: 5),
                width: index == currentIndex ? 15 : 10,
                height: index == currentIndex ? 15 : 10,
                decoration: BoxDecoration(
                  color:
                      index == currentIndex ? kPrimaryGreen : kSeconderyGreen,
                  shape: BoxShape.circle,
                ),
              )),
    );
  }
}
