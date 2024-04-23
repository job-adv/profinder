class UserPostEntity {
  final String? userId;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? address;
  final String? phoneNumber;
  final String? profilePic;
  final int? available;
  final int? verified;

  UserPostEntity({
    this.userId,
    this.username,
    this.firstname,
    this.lastname,
    this.address,
    this.phoneNumber,
    this.profilePic,
    this.available,
    this.verified,
  });

  factory UserPostEntity.fromJson(Map<String, dynamic> json) {
    return UserPostEntity(
      userId: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      profilePic: json['profile_picture'],
      available: json['available'],
      verified: json['verifier'],
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
      'profile_pic': profilePic,
      'available': available,
      'verified': verified,
    };
  }
}