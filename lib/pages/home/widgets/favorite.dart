import 'package:flutter/material.dart';
import 'package:profinder/models/favorite/favorite.dart';
import 'package:profinder/pages/home/service_detail.dart';

class FavoriteWidget extends StatelessWidget {
  final Favorite favorite;
  final int maxDescriptionLength;
  final VoidCallback onPress;

  const FavoriteWidget({
    Key? key,
    required this.favorite,
    required this.onPress,
    this.maxDescriptionLength = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetail(
              serviceId: favorite.service.serviceId,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.0),
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    favorite.professional.profilePicture,
                  ),
                  radius: 20.0,
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite.service.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      '${favorite.professional.firstname} ${favorite.professional.lastname}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.red,
                  onPressed: onPress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
