import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/favorite/favorite_creation_request.dart';
import 'package:profinder/pages/home/widgets/post/book_appointment.dart';
import 'package:profinder/pages/messages/chat_room.dart';
import 'package:profinder/services/favorite/favorite.dart';

import '../../../../utils/theme_data.dart';

class PostToolBar extends StatefulWidget {
  final IconData icon1;
  final IconData? icon2;
  final IconData? icon3;
  final String? user_id;
  final String? firstname;
  final String? lastname;
  final String? pictureUrl;
  final bool? available;
  final int? serviceId;
  final bool? isFavorite;

  const PostToolBar({
    Key? key,
    required this.icon1,
    this.icon2,
    this.serviceId,
    this.icon3,
    this.user_id,
    this.firstname,
    this.lastname,
    this.pictureUrl,
    this.available,
    this.isFavorite,
  }) : super(key: key);

  @override
  _PostToolBarState createState() => _PostToolBarState();
}

class _PostToolBarState extends State<PostToolBar> {
  FavoriteService favorite = FavoriteService();
  bool _isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _isButtonDisabled = widget.isFavorite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            widget.icon1,
            color: AppTheme.primaryColor,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(
                  available: widget.available!,
                  firstname: widget.firstname!,
                  lastname: widget.lastname!,
                  pictureUrl: widget.pictureUrl!,
                  user_id: widget.user_id!,
                ),
              ),
            );
          },
        ),
        if (widget.icon3 != null)
          IconButton(
            icon: Icon(
              widget.icon3,
              color: AppTheme.primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateAppointmentPage(
                    serviceId: widget.serviceId!,
                    professionalId: widget.user_id!,
                  ),
                ),
              );
            },
          ),
        if (widget.icon2 != null)
          IconButton(
            icon: Icon(
              widget.isFavorite!
                  ? FluentIcons.bookmark_16_filled
                  : FluentIcons.bookmark_16_regular,
              color: AppTheme.primaryColor,
            ),
            onPressed: _isButtonDisabled
                ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Le Service est déja dans la liste des favoris'), // Confirmation message
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                : () async {
                    FavoriteCreationRequest fav = FavoriteCreationRequest(
                      serviceId: widget.serviceId!,
                    );

                    try {
                      await favorite.post(fav);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Ajouté au favoris'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      setState(() {
                        _isButtonDisabled = true;
                      });
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Erreur $e'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
          ),
      ],
    );
  }
}
