import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class HeadingTitle extends StatelessWidget {
  final String text;
  const HeadingTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppTheme.elementTitle,
          ),
        ],
      ),
    );
  }
}
