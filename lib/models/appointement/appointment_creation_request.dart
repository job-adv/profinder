class AppointementCreationRequest {
  final String description;
  final int serviceId;
  final String professionalId;

  AppointementCreationRequest({
    required this.description,
    required this.serviceId,
    required this.professionalId,
  });

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'service_id': serviceId,
      'p_id': professionalId,
    };
  }
}
