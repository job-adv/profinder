class FavoriteCreationRequest {
  final int serviceId;

  FavoriteCreationRequest({
    required this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
    };
  }
}
