class PostCreationRequest {
  String title;
  String description;

  PostCreationRequest({
    required this.title,
    required this.description,
  });

  factory PostCreationRequest.fromJson(Map<String, dynamic> json) {
    return PostCreationRequest(
      title: json['title'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
    };
  }
}
