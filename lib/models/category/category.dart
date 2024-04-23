import 'package:profinder/models/subcategory/subcategory.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String picture;
  final String icon;
  final List<SubCategoryEntity> subcategories;

  CategoryEntity({
    required this.id,
    required this.name,
    required this.picture,
    required this.icon,
    required this.subcategories,
  });

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    // Parse subcategories list
    List<dynamic> subcategoriesJson = json['subcategories'];
    List<SubCategoryEntity> subcategories = subcategoriesJson
        .map((subcategoryJson) => SubCategoryEntity.fromJson(subcategoryJson))
        .toList();

    return CategoryEntity(
      id: json['category_id'],
      name: json['category_name'],
      picture: json['category_picture'],
      icon: json['category_icon'],
      subcategories: subcategories,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> subcategoriesJsonList =
        subcategories.map((subcategory) => subcategory.toJson()).toList();

    return {
      'category_id': id,
      'category_name': name,
      'category_picture': picture,
      'category_icon': icon,
      'subcategories': subcategoriesJsonList,
    };
  }
}
