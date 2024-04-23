class GenericSearchResponse {
  List<Artisan> artisans;
  List<Client> clients;
  List<Service> services;
  List<Post> posts;

  GenericSearchResponse({
    required this.artisans,
    required this.clients,
    required this.services,
    required this.posts,
  });

  factory GenericSearchResponse.fromJson(Map<String, dynamic> json) {
    return GenericSearchResponse(
      artisans: (json['artisans'] as List<dynamic>?)
              ?.map((e) => Artisan.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      clients: (json['clients'] as List<dynamic>?)
              ?.map((e) => Client.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      services: (json['services'] as List<dynamic>?)
              ?.map((e) => Service.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      posts: (json['posts'] as List<dynamic>?)
              ?.map((e) => Post.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artisans': artisans.map((e) => e.toJson()).toList(),
      'clients': clients.map((e) => e.toJson()).toList(),
      'services': services.map((e) => e.toJson()).toList(),
      'posts': posts.map((e) => e.toJson()).toList(),
    };
  }
}

class Artisan {
  String userId;
  String role;
  String username;
  String firstname;
  String lastname;
  String email;
  String address;
  String phoneNumber;
  String instagramLink;
  String facebookLink;
  String tiktokLink;
  String profilePicture;

  Artisan({
    required this.userId,
    required this.role,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.instagramLink,
    required this.facebookLink,
    required this.tiktokLink,
    required this.profilePicture,
  });

  factory Artisan.fromJson(Map<String, dynamic> json) {
    return Artisan(
      userId: json['user_id'] ?? '',
      role: json['role'] ?? '',
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      instagramLink: json['instagram_link'] ?? '',
      facebookLink: json['facebook_link'] ?? '',
      tiktokLink: json['tiktok_link'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'role': role,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'instagram_link': instagramLink,
      'facebook_link': facebookLink,
      'tiktok_link': tiktokLink,
      'profile_picture': profilePicture,
    };
  }
}

class Client {
  String userId;
  String role;
  String username;
  String firstname;
  String lastname;
  String email;
  String address;
  String phoneNumber;
  String instagramLink;
  String facebookLink;
  String tiktokLink;
  String profilePicture;
  String disponible;

  Client({
    required this.userId,
    required this.role,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.address,
    required this.phoneNumber,
    required this.instagramLink,
    required this.facebookLink,
    required this.tiktokLink,
    required this.profilePicture,
    required this.disponible,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      userId: json['user_id'] ?? '',
      role: json['role'] ?? '',
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      instagramLink: json['instagram_link'] ?? '',
      facebookLink: json['facebook_link'] ?? '',
      tiktokLink: json['tiktok_link'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      disponible: json['disponible'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'role': role,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'instagram_link': instagramLink,
      'facebook_link': facebookLink,
      'tiktok_link': tiktokLink,
      'profile_picture': profilePicture,
      'disponible': disponible,
    };
  }
}

class Service {
  int serviceId;
  String title;
  String description;
  String status;
  int subcategoryId;
  User user;
  List<Picture> pictures;
  List<Price> prices;

  Service({
    required this.serviceId,
    required this.title,
    required this.description,
    required this.status,
    required this.subcategoryId,
    required this.user,
    required this.pictures,
    required this.prices,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      subcategoryId: json['subcategory_id'] ?? 0,
      user: User.fromJson(json['user'] ?? {}),
      pictures: (json['pictures'] as List<dynamic>?)
              ?.map((e) => Picture.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      prices: (json['prices'] as List<dynamic>?)
              ?.map((e) => Price.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'title': title,
      'description': description,
      'status': status,
      'subcategory_id': subcategoryId,
      'user': user.toJson(),
      'pictures': pictures.map((e) => e.toJson()).toList(),
      'prices': prices.map((e) => e.toJson()).toList(),
    };
  }
}

class Post {
  int postId;
  String title;
  String createdAt;
  String description;
  String status;
  String userId;
  String username;
  String firstname;
  String lastname;
  String address;
  String? phoneNumber;
  String? instagramLink;
  String? facebookLink;
  String? tiktokLink;
  String? profilePicture;
  int? post_id;
  String? post_title;
  String? post_created_at;
  String? post_description;
  String? post_status;

  Post({
    required this.postId,
    required this.title,
    required this.createdAt,
    required this.description,
    required this.status,
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.address,
    this.phoneNumber,
    this.instagramLink,
    this.facebookLink,
    this.tiktokLink,
    this.profilePicture,
    this.post_id,
    this.post_title,
    this.post_created_at,
    this.post_description,
    this.post_status,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['post_id'] ?? 0,
      title: json['title'] ?? '',
      createdAt: json['created_at'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      userId: json['user_id'] ?? '',
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      instagramLink: json['instagram_link'] ?? '',
      facebookLink: json['facebook_link'] ?? '',
      tiktokLink: json['tiktok_link'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      post_id: json['post_id'],
      post_title: json['title'],
      post_created_at: json['post_created_at'],
      post_description: json['description'],
      post_status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'title': title,
      'created_at': createdAt,
      'description': description,
      'status': status,
      'user_id': userId,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'phone_number': phoneNumber,
      'instagram_link': instagramLink,
      'facebook_link': facebookLink,
      'tiktok_link': tiktokLink,
      'profile_picture': profilePicture,
      'post_title': post_title,
      'post_created_at': post_created_at,
      'post_description': post_description,
      'post_status': post_status,
    };
  }
}

class User {
  String userId;
  String username;
  String firstname;
  String lastname;
  String address;
  String phoneNumber;
  String instagramLink;
  String facebookLink;
  String tiktokLink;
  String profilePicture;
  int? post_id;
  String? post_title;
  String? post_created_at;
  String? post_description;
  String? post_status;

  User({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.phoneNumber,
    required this.instagramLink,
    required this.facebookLink,
    required this.tiktokLink,
    required this.profilePicture,
    this.post_id,
    this.post_title,
    this.post_created_at,
    this.post_description,
    this.post_status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['user_id'] ?? '',
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      address: json['address'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      instagramLink: json['instagram_link'] ?? '',
      facebookLink: json['facebook_link'] ?? '',
      tiktokLink: json['tiktok_link'] ?? '',
      profilePicture: json['profile_picture'] ?? '',
      post_id: json['post_id'],
      post_title: json['title'],
      post_created_at: json['post_created_at'],
      post_description: json['description'],
      post_status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'address': address,
      'phone_number': phoneNumber,
      'instagram_link': instagramLink,
      'facebook_link': facebookLink,
      'tiktok_link': tiktokLink,
      'profile_picture': profilePicture,
      'post_id': post_id,
      'post_title': post_title,
      'post_created_at': post_created_at,
      'post_description': post_description,
      'post_status': post_status,
    };
  }
}

class Picture {
  int pictureId;
  String link;

  Picture({
    required this.pictureId,
    required this.link,
  });

  factory Picture.fromJson(Map<String, dynamic> json) {
    return Picture(
      pictureId: json['picture_id'] ?? 0,
      link: json['link'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'picture_id': pictureId,
      'link': link,
    };
  }
}

class Price {
  int priceId;
  String value;
  String description;
  String rate;

  Price({
    required this.priceId,
    required this.value,
    required this.description,
    required this.rate,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      priceId: json['price_id'] ?? 0,
      value: json['value'] ?? 0,
      description: json['description'] ?? '',
      rate: json['rate'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price_id': priceId,
      'value': value,
      'description': description,
      'rate': rate,
    };
  }
}
