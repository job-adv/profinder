import 'package:flutter/material.dart';
import 'package:profinder/utils/constants.dart';

class StatedAvatar extends StatelessWidget {
  final String? imageUrl;
  final bool? online;

  const StatedAvatar({
    Key? key,
    required this.imageUrl,
    this.online,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: Image.network(
            imageUrl ?? Constants.defaultAvatar,
            fit: BoxFit.cover,
          ).image,
        ),
        if (online != null)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: online! ? Colors.green : Colors.grey,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
