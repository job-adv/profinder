import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:profinder/models/post/post.dart';
import 'package:profinder/services/post/post.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/pages/home/widgets/post/post.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class PostsPage extends StatefulWidget {
  final String? userId;
  final String? jwtToken;
  const PostsPage({
    super.key,
    required this.userId,
    required this.jwtToken,
  });

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late Future<List<PostEntity>> _posts;

  final PostService post = PostService();

  late String? currentUserId;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    loadUserId();
  }

  Future<void> _loadPosts() async {
    _posts = post.fetch();
  }

  Future<void> loadUserId() async {
    final FlutterSecureStorage secureStorage = FlutterSecureStorage();
    final String? jwtToken = await secureStorage.read(key: 'userId');

    setState(() {
      currentUserId = jwtToken ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 18),
                child: Text(
                  'Demandes récentes',
                  style: AppTheme.elementTitle,
                ),
              )
            ],
          ),
          VerticalList<PostEntity>(
            future: _posts,
            errorMessage: "Aucun service",
            emptyText: "Aucune publiciation",
            itemBuilder: (post) {
              return Post(
                title: post.title,
                description: post.description,
                username: post.username,
                firstname: post.firstname,
                lastname: post.lastname,
                pictureUrl: post.profilePicture,
                location: post.address,
                phoneNumber: post.phoneNumber,
                available: true,
                status: post.status,
                userId: post.userId,
                currentUserId: currentUserId,
                jwtToken: widget.jwtToken,
              );
            },
          ),
        ],
      ),
    );
  }
}
