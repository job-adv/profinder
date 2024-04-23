class Favorite {
  final int favoriteId;
  final Service service;
  final Professional professional;

  Favorite({
    required this.favoriteId,
    required this.service,
    required this.professional,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      favoriteId: json['favorite_id'],
      service: Service.fromJson(json['service']),
      professional: Professional.fromJson(json['professional']),
    );
  }
}

class Service {
  final int serviceId;
  final String title;
  final String description;
  final String status;

  Service({
    required this.serviceId,
    required this.title,
    required this.description,
    required this.status,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceId: json['service_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
    );
  }
}

class Professional {
  final String userId;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String role;
  final String profilePicture;

  Professional({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.role,
    required this.profilePicture,
  });

  factory Professional.fromJson(Map<String, dynamic> json) {
    return Professional(
      userId: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      role: json['role'],
      profilePicture: json['profile_picture'],
    );
  }
}
