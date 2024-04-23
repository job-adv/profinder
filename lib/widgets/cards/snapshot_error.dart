import 'dart:io';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:profinder/utils/error_handler/exceptions/data_exception.dart';
import 'package:profinder/utils/theme_data.dart';

class SnapshotErrorWidget extends StatelessWidget {
  final dynamic error;

  const SnapshotErrorWidget({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error is SocketException) {
      return Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.error_circle_12_filled,
                size: 50,
                color: AppTheme.secondaryColor,
              ),
              Text(
                "Une erreur est survenue",
                style: AppTheme.headingTextStyle,
              ),
            ],
          ),
        ),
      );
    } else if (error is DataException) {
      return Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.error_circle_12_filled,
                size: 50,
                color: AppTheme.secondaryColor,
              ),
              Text(
                "Une erreur est survenue",
                style: AppTheme.headingTextStyle,
              ),
            ],
          ),
        ),
      );
    } else if (error.runtimeType == Null) {
      return Center(child: Text('User data is null'));
    } else if (error is ClientException) {
      return Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.error_circle_12_filled,
                size: 50,
                color: AppTheme.secondaryColor,
              ),
              Text(
                "Une erreur est survenue",
                style: AppTheme.headingTextStyle,
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.error_circle_12_filled,
                size: 50,
                color: AppTheme.secondaryColor,
              ),
              Text(
                "Une erreur est survenue",
                style: AppTheme.headingTextStyle,
              ),
            ],
          ),
        ),
      );
    }
  }
}
