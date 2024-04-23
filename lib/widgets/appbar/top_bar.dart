import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/notification/notification.dart';
import 'package:profinder/pages/overlays/notifications.dart';
import 'package:profinder/services/notification/notification.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const TopBar({Key? key, required this.title}) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _TopBarState extends State<TopBar> {
  int unreadCount = 0;

  final NotificationService notificationService = NotificationService();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  List<NotificationEntity> notifications = []; // List to hold notifications
  Set<int> readNotificationIds = {}; // Set to hold IDs of read notifications

  @override
  void initState() {
    super.initState();
    _fetchNotifications();
    _loadReadNotificationIds();
  }

  Future<void> _fetchNotifications() async {
    try {
      List<NotificationEntity> fetchedNotifications =
          await notificationService.fetch();
      setState(() {
        notifications = fetchedNotifications;
        unreadCount = _calculateUnreadCount(notifications);
      });
    } catch (error) {
      print('Error fetching notifications: $error');
    }
  }

  int _calculateUnreadCount(List<NotificationEntity> notifications) {
    int count = 0;
    for (var notification in notifications) {
      if (!readNotificationIds.contains(notification.notificationId)) {
        count++;
      }
    }
    return count;
  }

  void _markNotificationsAsRead() {
    setState(() {
      readNotificationIds.addAll(notifications
          .map((n) => n.notificationId)); // Mark notifications as read
      unreadCount = 0; // Reset unread count
    });
    _saveReadNotificationIds(); // Save read notification IDs to secure storage
  }

  Future<void> _loadReadNotificationIds() async {
    try {
      String? readIds = await secureStorage.read(key: 'readNotificationIds');
      print('Read IDs from storage: $readIds');
      if (readIds != null && readIds.isNotEmpty) {
        setState(() {
          readNotificationIds = readIds
              .split(',')
              .map((id) => int.tryParse(id.trim()) ?? 0)
              .toSet();
        });
      }
    } catch (error) {
      print('Error loading read notification IDs: $error');
    }
  }

  Future<void> _saveReadNotificationIds() async {
    await secureStorage.write(
        key: 'readNotificationIds',
        value: readNotificationIds
            .join(',')); // Save read notification IDs to secure storage
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(FluentIcons.line_horizontal_3_20_filled),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Open navigation drawer
              },
            );
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  FluentIcons.alert_12_regular,
                  color: appThemeData.primaryColor,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Notifications()),
                  ).then((_) {
                    _markNotificationsAsRead(); // Mark notifications as read
                  });
                },
              ),
              if (unreadCount > 0)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
