class SubCategoryEntity {
  final int subCategoryId;
  final String subCategoryName;
  final String subCategoryPicture;
  final int categoryId;

  SubCategoryEntity({
    required this.subCategoryId,
    required this.subCategoryName,
    required this.subCategoryPicture,
    required this.categoryId,
  });

  factory SubCategoryEntity.fromJson(Map<String, dynamic> json) {
    return SubCategoryEntity(
      subCategoryId: json['subCategory_id'],
      subCategoryName: json['subCategory_name'],
      subCategoryPicture: json['subCategory_picture'],
      categoryId: json['category_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subCategory_id': subCategoryId,
      'subCategory_name': subCategoryName,
      'subCategory_picture': subCategoryPicture,
      'category_id': categoryId,
    };
  }
}
