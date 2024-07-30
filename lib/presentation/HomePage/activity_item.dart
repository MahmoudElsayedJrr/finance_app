import 'package:finance_application/core/ColorsConstants.dart';
import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  const ActivityItem({
    super.key,
    required this.Title,
    required this.date,
    required this.price,
    required this.isPlus,
  });
  final String Title, date;
  final double price;
  final bool isPlus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: isPlus ? kSeconderyGreen : kSeconderyRed,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Text(
                date,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(width: 5),
          Spacer(),
          Text(
            isPlus ? '+ \$ $price' : '- \$ $price',
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
