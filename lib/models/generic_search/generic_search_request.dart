class GenericSearchRequest {
  final String keyword;

  GenericSearchRequest({
    required this.keyword,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': keyword,
    };
  }
}
