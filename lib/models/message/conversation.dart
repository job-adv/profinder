class Conversation {
  int? conversationId;
  String? user1Id;
  String? user2Id;
  int? seen;
  String? userId;
  String? role;
  String? username;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  int? categoryId;
  String? cv;
  String? address;
  String? createdAt;
  int? verifier;
  String? phoneNumber;
  String? profilePicture;
  String? facebookLink;
  String? instagramLink;
  String? tiktokLink;
  int? disponible;
  String? lastMessage;
  String? lastMessageTimestamp;

  Conversation({
    required this.conversationId,
    required this.user1Id,
    required this.user2Id,
    required this.seen,
    required this.userId,
    required this.role,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.categoryId,
    this.cv,
    this.address,
    required this.createdAt,
    required this.verifier,
    required this.phoneNumber,
    required this.profilePicture,
    this.facebookLink,
    this.instagramLink,
    this.tiktokLink,
    required this.disponible,
    required this.lastMessage,
    required this.lastMessageTimestamp,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      conversationId: json['conversation_id'] as int?,
      user1Id: json['user1_id'] as String?,
      user2Id: json['user2_id'] as String?,
      seen: json['seen'] as int?,
      userId: json['user_id'] as String?,
      role: json['role'] as String?,
      username: json['username'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      categoryId: json['category_id'] as int?,
      cv: json['cv'] as String?,
      address: json['adress'] as String?,
      createdAt: json['created_at'] as String?,
      verifier: json['verifier'] as int?,
      phoneNumber: json['phone_number'] as String?,
      profilePicture: json['profile_picture'] as String?,
      facebookLink: json['facebook_link'] as String?,
      instagramLink: json['instagram_link'] as String?,
      tiktokLink: json['tiktok_link'] as String?,
      disponible: json['disponible'] as int?,
      lastMessage: json['last_message'] as String?,
      lastMessageTimestamp: json['last_message_timestamp'] as String,
    );
  }
}
