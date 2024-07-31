import 'package:finance_application/core/ColorsConstants.dart';
import 'package:flutter/material.dart';

class DismissibleButton extends StatelessWidget {
  const DismissibleButton({
    super.key,
    this.onDismissed,
    required this.child,
  });
  final Function(DismissDirection)? onDismissed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          decoration: BoxDecoration(
            color: kPrimaryGreen,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.edit, color: KWhiteColor),
                SizedBox(width: 10),
                Text('Edit',
                    style: TextStyle(
                        color: KWhiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            color: kPrimaryRed,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.remove_circle_outline_outlined,
                  color: KWhiteColor,
                ),
                SizedBox(width: 10),
                Text('Remove',
                    style: TextStyle(
                        color: KWhiteColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
        onDismissed: onDismissed,
        child: child);
  }
}
