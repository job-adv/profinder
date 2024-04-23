import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/post/post_creation_request.dart';
import 'package:profinder/services/post/post.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/buttons/filled_button.dart';
import 'package:profinder/widgets/inputs/rounded_text_field.dart';
import 'package:profinder/widgets/inputs/text_area.dart';

class NewPost extends StatelessWidget {
  const NewPost({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    final PostService _postService = PostService();

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Créer une demande",
                  style: AppTheme.headingTextStyle,
                )
              ],
            ),
          ),
          RoundedTextField(
            controller: _titleController,
            hintText: "Titre",
            icon: FluentIcons.text_header_1_lines_16_filled,
          ),
          RoundedTextArea(
            controller: _descriptionController,
            hintText: "Description",
            icon: FluentIcons.text_paragraph_16_filled,
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: FilledAppButton(
              icon: FluentIcons.add_12_filled,
              text: "Publier",
              onPressed: () async {
                if (_titleController.text.isEmpty ||
                    _descriptionController.text.isEmpty) {
                  // If any of the fields are empty, show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Veuillez remplir tous les champs',
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  // If all fields are filled, proceed with posting
                  PostCreationRequest data = PostCreationRequest(
                    title: _titleController.text,
                    description: _descriptionController.text,
                  );
                  try {
                    await _postService.post(data);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Contenu publié avec succès!',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    _postService.fetch();
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Veuillez vérifier vos coordonnées',
                        ),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
