import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class OverlayTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData dismissIcon;
  final Color? color;
  final Color? buttonsColor;
  final Widget? action;

  const OverlayTopBar({
    Key? key,
    required this.title,
    required this.dismissIcon,
    this.color,
    this.buttonsColor,
    this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: AppBar(
        backgroundColor: color ?? Colors.white,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            dismissIcon,
            color: buttonsColor ?? appThemeData.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [action ?? Container()],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
