class UserEntity {
  final String userId;
  final String firstname;
  final String lastname;
  final String email;
  final String username;
  final String role;
  final int? categoryId;
  final String? address;
  final String? phoneNumber;
  final String? instagramLink;
  final String? tiktokLink;
  final String? facebookLink;
  final String? profilePic;
  final String? cv;
  final int? available;
  final int? verified;

  UserEntity({
    required this.userId,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.role,
    this.categoryId,
    required this.address,
    required this.phoneNumber,
    required this.instagramLink,
    required this.tiktokLink,
    required this.facebookLink,
    required this.profilePic,
    this.cv,
    required this.available,
    required this.verified,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      userId: json['user_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      username: json['username'],
      role: json['role'],
      categoryId: json['category_id'],
      address: json['adress'],
      phoneNumber: json['phone_number'],
      instagramLink: json['instagram_link'],
      tiktokLink: json['tiktok_link'],
      facebookLink: json['facebook_link'],
      profilePic: json['profile_picture'],
      cv: json['cv'],
      available: json['disponible'],
      verified: json['verifier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'username': username,
      'role': role,
      'category_id': categoryId,
      'adress': address,
      'phone_number': phoneNumber,
      'instagram_link': instagramLink,
      'tiktok_link': tiktokLink,
      'facebook_link': facebookLink,
      'profile_picture': profilePic,
      'cv': cv,
      'disponible': available,
      'verifier': verified,
    };
  }
}
