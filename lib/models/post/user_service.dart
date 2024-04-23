class ServiceDataEntity {
  final int serviceId;
  final String? title;
  final String? description;
  final User user;
  final List<Picture> pictures;
  final List<Price> prices;

  ServiceDataEntity({
    required this.serviceId,
    this.title,
    this.description,
    required this.user,
    required this.pictures,
    required this.prices,
  });

  factory ServiceDataEntity.fromJson(Map<String, dynamic> json) {
    return ServiceDataEntity(
      serviceId: json['service_id'],
      title: json['title'],
      description: json['description'],
      user: User.fromJson(json['user']),
      pictures: (json['pictures'] as List<dynamic>)
          .map((pictureJson) => Picture.fromJson(pictureJson))
          .toList(),
      prices: (json['prices'] as List<dynamic>)
          .map((priceJson) => Price.fromJson(priceJson))
          .toList(),
    );
  }
}

class User {
  final String? userId;
  final String? firstName;
  final String? lastName;
  final String? address;
  final String? phoneNumber;

  User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.address,
    required this.phoneNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'],
      firstName: json['firstname'],
      lastName: json['lastname'],
      address: json['adress'],
      phoneNumber: json['phone_number'],
    );
  }
}

class Picture {
  final int? pictureId;
  final String? link;

  Picture({
    required this.pictureId,
    required this.link,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureId: json['picture_id'],
      link: json['link'],
    );
  }
}

class Price {
  final int? priceId;
  final double? value;
  final String? description;

  Price({
    required this.priceId,
    required this.value,
    required this.description,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      priceId: json['price_id'],
      value: double.parse(json['value']),
      description: json['description'],
    );
  }
}
