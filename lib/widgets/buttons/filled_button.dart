import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class FilledAppButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;

  const FilledAppButton({
    Key? key,
    required this.icon,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            return AppTheme.primaryColor; // Set your desired background color
          },
        ),
        foregroundColor:
            MaterialStateProperty.all<Color>(Colors.white), // Set text color
      ),
    );
  }
}
