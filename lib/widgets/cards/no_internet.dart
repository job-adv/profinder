import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/utils/error_handler/connectivity_check.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/navigation/main_navigation_bar.dart';

class InternetError extends StatelessWidget {
  const InternetError({Key? key}) : super(key: key);

  Future<void> _handleConnection(BuildContext context) async {
    bool isConnected = await ConnectivityCheck.isConnected();
    if (isConnected) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainNavBar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FluentIcons.plug_disconnected_16_filled,
              size: 50,
              color: AppTheme.secondaryColor,
            ),
            Text(
              "Vous êtes hors ligne",
              style: AppTheme.headingTextStyle,
            ),
            SizedBox(height: 20),
            FilledAppButton(
              onPressed: () => _handleConnection(context),
              text: 'Réessayer',
              icon: FluentIcons.arrow_rotate_clockwise_16_filled,
            ),
          ],
        ),
      ),
    );
  }
}
