import 'package:profinder/models/post/picture.dart';
import 'package:profinder/models/post/price_creation_request.dart';

class ServiceCreationRequest {
  final String title;
  final String description;
  final int subCategoryId;
  final List<Picture> pictures;
  final List<PriceCreationRequest> prices;

  ServiceCreationRequest({
    required this.title,
    required this.description,
    required this.subCategoryId,
    required this.pictures,
    required this.prices,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> pictureJsonList =
        pictures.map((picture) => picture.toJson()).toList();
    List<Map<String, dynamic>> pricesJsonList =
        prices.map((price) => price.toJson()).toList();

    return {
      'title': title,
      'description': description,
      'subCategory_id': subCategoryId,
      'pictures': pictureJsonList,
      'prices': pricesJsonList,
    };
  }
}
