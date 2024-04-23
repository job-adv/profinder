import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const ActionButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
      shape: CircleBorder(),
      backgroundColor: appThemeData.primaryColor,
      foregroundColor: Colors.white,
    );
  }
}
