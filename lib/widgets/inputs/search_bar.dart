import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/utils/theme_data.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function(String) onSubmitted;
  const SearchAppBar({
    Key? key,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  _SearchAppBarState createState() => _SearchAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: _searchController,
        cursorColor: Colors.white, // Set the cursor color
        decoration: InputDecoration(
          icon: Icon(
            FluentIcons.search_12_filled,
            color: AppTheme.secondaryColor,
          ),
          hintText: 'Rechercher',
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: AppTheme.textColor, // Set the text color explicitly
        ),
        onSubmitted: (__) => widget
            .onSubmitted(_searchController.text), // Use _searchController.text
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            _searchController.clear();
          },
        ),
      ],
    );
  }
}
