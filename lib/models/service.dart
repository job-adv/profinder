import 'package:profinder/models/picture.dart';
import 'package:profinder/models/price.dart';
import 'package:profinder/models/user.dart';

class ServiceEntity {
  final int serviceId;
  final String title;
  final String description;
  final UserEntity user;
  final List<Picture> pictures;
  final List<Price> prices;

  ServiceEntity({
    required this.serviceId,
    required this.title,
    required this.description,
    required this.user,
    required this.pictures,
    required this.prices,
  });

  factory ServiceEntity.fromJson(Map<String, dynamic> json) {
    return ServiceEntity(
      serviceId: json['service_id'],
      title: json['title'],
      description: json['description'],
      user: UserEntity.fromJson(json['user']),
      pictures: (json['pictures'] as List<dynamic>)
          .map((pictureJson) => Picture.fromJson(pictureJson))
          .toList(),
      prices: (json['prices'] as List<dynamic>)
          .map((priceJson) => Price.fromJson(priceJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'title': title,
      'description': description,
      'user': user.toJson(),
      'pictures': pictures.map((picture) => picture.toJson()).toList(),
      'prices': prices.map((price) => price.toJson()).toList(),
    };
  }
}
