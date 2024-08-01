import 'package:flutter/material.dart';

class plusAndMinusButton extends StatelessWidget {
  const plusAndMinusButton({
    super.key,
    required this.name,
    required this.icon,
    required this.color,
    required this.ontap,
    required this.TextandIconColor,
  });
  final String name;
  final IconData icon;
  final Color color;
  final Color TextandIconColor;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: TextandIconColor,
            ),
            SizedBox(width: 2),
            Text(name, style: TextStyle(fontSize: 18, color: TextandIconColor))
          ],
        ),
      ),
    );
  }
}
