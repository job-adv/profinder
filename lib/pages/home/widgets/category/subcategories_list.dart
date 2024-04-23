import 'package:flutter/material.dart';
import 'package:profinder/models/subcategory/subcategory.dart';
import 'package:profinder/pages/home/services_by_subcategory.dart';
import 'package:profinder/pages/home/services_by_subcategory_guest.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class SubcategoryList extends StatefulWidget {
  final String categoryName;
  final List<SubCategoryEntity> subcategories;
  final String? jwtToken;
  const SubcategoryList({
    Key? key,
    required this.categoryName,
    required this.subcategories,
    required this.jwtToken,
  });

  @override
  State<SubcategoryList> createState() => _SubcategoryListState();
}

class _SubcategoryListState extends State<SubcategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: "${widget.categoryName} (${widget.subcategories.length})",
        dismissIcon: FluentIcons.dismiss_12_filled,
      ),
      body: ListView.builder(
        itemCount: widget.subcategories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (widget.jwtToken != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesByCategory(
                        subCategoryName:
                            widget.subcategories[index].subCategoryName,
                        subCategoryId:
                            widget.subcategories[index].subCategoryId),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServicesByCategoryGuest(
                        subCategoryName:
                            widget.subcategories[index].subCategoryName,
                        subCategoryId:
                            widget.subcategories[index].subCategoryId),
                  ),
                );
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Stack(
                children: [
                  Image.network(
                    widget.subcategories[index].subCategoryPicture,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200, // Adjust height as needed
                  ),
                  Container(
                    width: double.infinity,
                    height: 200, // Adjust height as needed
                    color: Colors.black
                        .withOpacity(0.4), // Adjust opacity as needed
                    child: Center(
                      child: Text(
                        widget.subcategories[index].subCategoryName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20, // Adjust font size as needed
                          fontWeight:
                              FontWeight.bold, // Adjust font weight as needed
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
