import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class TextAppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const TextAppButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: AppTheme.secondaryColor,
        ),
      ),
    );
  }
}
