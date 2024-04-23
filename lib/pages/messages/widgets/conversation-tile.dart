import 'package:flutter/material.dart';
import 'package:profinder/utils/helpers.dart';

class ConversationTile extends StatelessWidget {
  final String pictureUrl;
  final String username;
  final bool onlineStatus;
  final String latestMessage;
  final String sentTime;
  final num? unreadCount;
  final VoidCallback? onPressed;

  const ConversationTile({
    super.key,
    required this.pictureUrl,
    required this.username,
    required this.onlineStatus,
    required this.latestMessage,
    required this.sentTime,
    required this.onPressed,
    this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(pictureUrl),
      ),
      title: Text(username),
      subtitle: Text(latestMessage),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 7,
          ),
          Text(Helpers.formattedSentTime(sentTime)),
          SizedBox(
            height: 10,
          ),
          Text(Helpers.formattedSentTimeDate(sentTime)),
        ],
      ),
    );
  }
}
