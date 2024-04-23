class NotificationEntity {
  final int notificationId;
  final String content;
  final String userId;
  final String role;
  final String username;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String? categoryId;
  final String? cv;
  final String address;
  final DateTime createdAt;
  final int verifier;
  final String phoneNumber;
  final String profilePicture;
  final String facebookLink;
  final String instagramLink;
  final String tiktokLink;
  final int disponible;

  NotificationEntity({
    required this.notificationId,
    required this.content,
    required this.userId,
    required this.role,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.categoryId,
    this.cv,
    required this.address,
    required this.createdAt,
    required this.verifier,
    required this.phoneNumber,
    required this.profilePicture,
    required this.facebookLink,
    required this.instagramLink,
    required this.tiktokLink,
    required this.disponible,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      notificationId: json['notification_id'],
      content: json['content'],
      userId: json['user_id'],
      role: json['role'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      password: json['password'],
      categoryId: json['category_id'],
      cv: json['cv'],
      address: json['adress'],
      createdAt: DateTime.parse(json['created_at']),
      verifier: json['verifier'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
      facebookLink: json['facebook_link'],
      instagramLink: json['instagram_link'],
      tiktokLink: json['tiktok_link'],
      disponible: json['disponible'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notification_id': notificationId,
      'content': content,
      'user_id': userId,
      'role': role,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'category_id': categoryId,
      'cv': cv,
      'adress': address,
      'created_at': createdAt.toIso8601String(),
      'verifier': verifier,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
      'facebook_link': facebookLink,
      'instagram_link': instagramLink,
      'tiktok_link': tiktokLink,
      'disponible': disponible,
    };
  }
}
