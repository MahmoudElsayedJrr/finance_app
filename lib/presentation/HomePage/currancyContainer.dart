import 'package:finance_application/core/ColorsConstants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class currancyContainer extends StatelessWidget {
  const currancyContainer({
    super.key,
    required this.secondryColor,
    required this.title,
    required this.price,
  });
  final Color secondryColor;
  final String title;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(8),
              height: 125,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12)),
                  color: KBlackColor),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 14, color: KWhiteColor),
                    ),
                    SizedBox(height: 3),
                    Text(
                      '${NumberFormat.compactCurrency(decimalDigits: 2, symbol: 'EGP ').format(price).toString()}',
                      style: TextStyle(fontSize: 35, color: KWhiteColor),
                    ),
                  ],
                ),
              ),
            )),
        Flexible(
          flex: 1,
          child: Container(
            padding: EdgeInsets.all(8),
            height: 125,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)),
                color: secondryColor),
          ),
        ),
      ],
    );
  }
}
