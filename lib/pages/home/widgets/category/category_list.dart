import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:profinder/models/category/category.dart';
import 'package:profinder/pages/home/widgets/category/subcategories_list.dart';
import 'package:profinder/services/category/category.dart';
import 'package:profinder/utils/theme_data.dart';
import 'package:profinder/widgets/appbar/overlay_top_bar.dart';
import 'package:profinder/widgets/lists/generic_vertical_list.dart';

class CategoryList extends StatefulWidget {
  final String? jwtToken;
  const CategoryList({
    Key? key,
    this.jwtToken,
  });

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late Future<List<CategoryEntity>> _categoriesFuture;
  late int _categoriesLength = 0;

  final CategoryService category = CategoryService();

  Future<void> _loadCategories() async {
    _categoriesFuture = category.fetch();
    final categories = await _categoriesFuture;
    setState(() {
      _categoriesLength = categories.length;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: OverlayTopBar(
        title: 'Tous les catégories (${_categoriesLength})',
        dismissIcon: FluentIcons.dismiss_12_filled,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            VerticalList<CategoryEntity>(
              future: _categoriesFuture,
              errorMessage: "Aucun catégorie",
              emptyText: "Aucune catégorie",
              itemBuilder: (category) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubcategoryList(
                          categoryName: category.name,
                          subcategories: category.subcategories,
                          jwtToken: widget.jwtToken,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Stack(
                      children: [
                        Image.network(
                          category.picture,
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
                              category.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20, // Adjust font size as needed
                                fontWeight: FontWeight
                                    .bold, // Adjust font weight as needed
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
          ],
        ),
      ),
    );
  }
}
