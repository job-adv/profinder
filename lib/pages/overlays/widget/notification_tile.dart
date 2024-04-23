import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {
  final String username;
  final bool onlineStatus;
  final String latestMessage;
  final VoidCallback? onPressed;

  const NotificationTile({
    super.key,
    required this.username,
    required this.onlineStatus,
    required this.latestMessage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(Icons.info, size: 48),
      title: Text(username),
      subtitle: Text(latestMessage),
    );
  }
}
