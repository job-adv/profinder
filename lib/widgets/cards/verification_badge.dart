import 'package:flutter/material.dart';

class VerificationBadge extends StatelessWidget {
  final bool isVerified;

  const VerificationBadge({required this.isVerified});

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color badgeColor;

    if (isVerified) {
      iconData = Icons.check;
      badgeColor = Colors.green;
    } else {
      iconData = Icons.close;
      badgeColor = Colors.red;
    }

    return Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: Colors.white,
        size: 12,
      ),
    );
  }
}
