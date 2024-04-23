import 'package:profinder/models/category/category.dart';
import 'package:profinder/models/subcategory/subcategory.dart';
import 'package:profinder/services/data.dart';
import 'package:profinder/utils/error_handler/exceptions/data_exception.dart';

class CategoryService {
  final GenericDataService<CategoryEntity> _genericService =
      GenericDataService<CategoryEntity>('category', {
    'get': 'view',
  });

  Future<List<CategoryEntity>> fetch() async {
    return _genericService.fetch((json) => CategoryEntity.fromJson(json));
  }

  Future<List<SubCategoryEntity>> fetchSubcategories(int categoryId) async {
    List<CategoryEntity> categories = await fetch();
    CategoryEntity category = categories.firstWhere(
      (category) => category.id == categoryId,
      orElse: () => throw DataException('Category not found'),
    );
    return List<SubCategoryEntity>.from(category.subcategories);
  }
}
