import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:profinder/models/category.dart';

import '../utils/constants.dart';

class CategoryService {
  final String path = 'category';

  Future<List<CategoryEntity>> fetchCategories() async {
    final url = Constants.apiUrl;
    final response = await http.get(Uri.parse('$url/$path/view'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final List<CategoryEntity> categories =
          List<CategoryEntity>.from(parsed['data'].map((category) {
        return CategoryEntity(
          id: category['category_id'],
          name: category['category_name'],
          picture: category['category_picture'],
          icon: category['category_icon'],
        );
      }));
      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
