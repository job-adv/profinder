import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class ContactDetail extends StatelessWidget {
  final String text;
  final IconData icon;

  const ContactDetail({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        top: 5,
        bottom: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(width: 5),
          Text(
            text,
            style: AppTheme.elementTitle,
          ),
        ],
      ),
    );
  }
}
