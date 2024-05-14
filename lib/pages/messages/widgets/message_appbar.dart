import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final String userName;
  final String profilePicUrl;
  final bool userStatus;

  const CustomAppBar({
    Key? key,
    this.onBack,
    required this.userName,
    required this.profilePicUrl,
    required this.userStatus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profilePicUrl),
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                userStatus ? 'Available' : 'Not available',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
