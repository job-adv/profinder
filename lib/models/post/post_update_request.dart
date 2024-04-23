class PostUpdateRequest {
  final String title;
  final String description;

  PostUpdateRequest({
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
