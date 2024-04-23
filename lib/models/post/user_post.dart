class OwnPostEntity {
  final int postId;
  final String title;
  final String description;
  final String status;
  final String userId;

  OwnPostEntity({
    required this.postId,
    required this.title,
    required this.description,
    required this.status,
    required this.userId,
  });

  factory OwnPostEntity.fromJson(Map<String, dynamic> json) {
    return OwnPostEntity(
      postId: json['post_id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      userId: json['user_id'],
    );
  }
}
