import 'package:flutter/material.dart';
import 'package:profinder/models/post/service_detail.dart';
import 'package:profinder/pages/home/widgets/full_screen_preview.dart'; // Import your full-screen preview page

class PictureList extends StatelessWidget {
  final List<Picture> pictures;

  const PictureList({
    Key? key,
    required this.pictures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return pictures.isNotEmpty
        ? SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: pictures.map((picture) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to full-screen preview page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenPreview(imageUrl: picture.link),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 150,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          picture.link,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        : Container();
  }
}
