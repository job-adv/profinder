class ReportEntity {
  final String description;

  ReportEntity({
    required this.description,
  });

  factory ReportEntity.fromJson(Map<String, dynamic> json) {
    return ReportEntity(
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
    };
  }
}
