import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/post/picture.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/home/widgets/post/post_toolbar.dart';
import 'package:profinder/widgets/cards/user_card.dart';

class PostService extends StatelessWidget {
  final String title;
  final String description;
  final String username;
  final String? firstname;
  final String? lastname;
  final String job;
  final int serviceId;
  final String? pictureUrl;
  final bool available;
  final String? userId;
  final String? currentUserId;
  final List<Picture>? pictures;
  final VoidCallback? onPress;
  final bool? isFavorite;

  const PostService({
    Key? key,
    required this.title,
    required this.description,
    required this.username,
    required this.job,
    required this.pictureUrl,
    required this.available,
    required this.serviceId,
    this.isFavorite,
    this.userId,
    this.currentUserId,
    this.firstname,
    this.lastname,
    this.pictures,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5, top: 20),
        child: Container(
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [AppTheme.globalShadow],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserCard(
                    pictureUrl: pictureUrl,
                    username: username,
                    content: job,
                    available: available,
                  ),
                  if (this.currentUserId != null &&
                      this.currentUserId != userId)
                    PostToolBar(
                      icon1: FluentIcons.send_16_regular,
                      icon2: FluentIcons.bookmark_16_regular,
                      icon3: FluentIcons.calendar_12_regular,
                      serviceId: serviceId,
                      firstname: firstname,
                      lastname: lastname,
                      pictureUrl: pictureUrl,
                      available: available,
                      user_id: userId,
                      isFavorite: isFavorite ?? false,
                    )
                ],
              ),
              SizedBox(height: 12),
              Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
              SizedBox(height: 10),
              Text(description),
              SizedBox(height: 10),
              Text("Realisations",
                  style: TextStyle(fontWeight: FontWeight.w700)),
              SizedBox(height: 10),
              Wrap(
                spacing: 15,
                runSpacing: 10,
                children: pictures != null
                    ? pictures!.take(3).map((picture) {
                        int index = pictures!.indexOf(picture);
                        return index == 2 // Check if it's the third picture
                            ? Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      picture.link,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppTheme.primaryColor
                                          .withOpacity(0.5),
                                      child: InkWell(
                                        onTap: onPress,
                                        child: Center(
                                          child: Text(
                                            'Voir plus',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  picture.link,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              );
                      }).toList()
                    : [],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
