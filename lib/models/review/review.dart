class Review {
  final String? userId;
  final String createdAt;
  final String comment;
  final int rating;
  final int serviceId;
  final int reviewId;

  Review({
    this.userId,
    required this.createdAt,
    required this.comment,
    required this.rating,
    required this.serviceId,
    required this.reviewId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      userId: json['user_id'] as String?,
      createdAt: json['created_at'] as String,
      comment: json['comment'] as String,
      rating: json['rating'] as int,
      serviceId: json['service_id'] as int,
      reviewId: json['review_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'created_at': createdAt,
      'comment': comment,
      'rating': rating,
      'service_id': serviceId,
      'review_id': reviewId,
    };
  }
}
