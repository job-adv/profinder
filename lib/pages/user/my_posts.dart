import 'package:flutter/material.dart';
import 'package:profinder/models/post/post_update_request.dart';
import 'package:profinder/models/post/user_post.dart';
import 'package:profinder/services/post/post.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';
import 'package:profinder/widgets/progress/loader.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key});

  @override
  State<MyPosts> createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  late Future<List<OwnPostEntity>> _posts;

  final PostService postService = PostService();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    _posts = postService.fetchUserPosts();
  }

  String statusBuilder(String s) {
    return s == 'active' ? 'En attente' : 'Terminé';
  }

  Color statusColor(String s) {
    return s == 'active' ? AppTheme.secondaryColor : Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(5),
        child: FutureBuilder<List<OwnPostEntity>>(
          future: _posts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AppLoading();
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final posts = snapshot.data!;
              return Column(
                children: posts.map((post) {
                  return _buildPostCard(post);
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildPostCard(OwnPostEntity post) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      elevation: 0.8, // Reduced shadow
      color: Colors.white, // Used primary color
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor(post.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                statusBuilder(post.status),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(width: 8),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.check_circle_outline),
                  color: Colors.green,
                  onPressed: () async {
                    try {
                      await postService
                          .setToComplete({"_status": "inactive"}, post.postId);
                      setState(() {
                        _loadPosts();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Demande est complété',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Une érreur est survenue veuillez réessayer',
                          ),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  color: AppTheme.primaryColor,
                  onPressed: () {
                    _editPost(context, post);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _editPost(BuildContext context, OwnPostEntity post) async {
    TextEditingController titleController =
        TextEditingController(text: post.title);
    TextEditingController descriptionController =
        TextEditingController(text: post.description);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: Text('Modifier demande'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RoundedTextField(
                controller: titleController,
                hintText: "Titre",
              ),
              RoundedTextArea(
                controller: descriptionController,
                hintText: "Description",
              ),
            ],
          ),
          actions: <Widget>[
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: FilledAppButton(
                    icon: Icons.close,
                    text: "Annuler",
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: FilledAppButton(
                    icon: Icons.save,
                    text: "Ok",
                    onPressed: () async {
                      PostUpdateRequest req = PostUpdateRequest(
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                      try {
                        await postService.updatePost(req, post.postId);
                        setState(() {
                          _loadPosts();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Post updated successfully'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('$e An error occurred. Please try again.'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
