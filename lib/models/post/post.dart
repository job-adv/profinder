class PostEntity {
  final String userId;
  final String username;
  final String firstname;
  final String lastname;
  final String? address;
  final String? phoneNumber;
  final String? profilePicture;
  final int postId;
  final String? title;
  final String? postCreatedAt;
  final String? description;
  final String? status;

  PostEntity({
    required this.userId,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.phoneNumber,
    required this.profilePicture,
    required this.postId,
    required this.title,
    required this.postCreatedAt,
    required this.description,
    required this.status,
  });

  factory PostEntity.fromJson(Map<String, dynamic> json) {
    return PostEntity(
      userId: json['user_id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
      postId: json['post_id'],
      title: json['title'],
      postCreatedAt: json['post_created_at'],
      description: json['description'],
      status: json['status'],
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
      'profile_picture': profilePicture,
      'post_id': postId,
      'title': title,
      'post_created_at': postCreatedAt,
      'description': description,
      'status': status,
    };
  }
}
