class UsageCondition {
  final String content;

  UsageCondition({
    required this.content,
  });

  factory UsageCondition.fromJson(Map<String, dynamic> json) {
    return UsageCondition(
      content: json['content'],
    );
  }
}
