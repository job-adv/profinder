class ReviewCreationRequest {
  String comment;
  int rating;
  int serviceId;

  ReviewCreationRequest({
    required this.comment,
    required this.rating,
    required this.serviceId,
  });

  factory ReviewCreationRequest.fromJson(Map<String, dynamic> json) {
    return ReviewCreationRequest(
      comment: json['comment'] ?? '',
      rating: json['rating'] ?? 0,
      serviceId: json['service_id'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['service_id'] = this.serviceId;
    return data;
  }
}
