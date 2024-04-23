class PriceCreationRequest {
  final int? serviceId;
  final int value;
  final String description;
  final String rate;

  PriceCreationRequest({
    this.serviceId,
    required this.value,
    required this.description,
    required this.rate,
  });

  factory PriceCreationRequest.fromJson(Map<String, dynamic> json) {
    return PriceCreationRequest(
      serviceId: json['service_id'],
      value: json['value'],
      description: json['description'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> jsonMap = {
      'value': value,
      'description': description,
      'rate': rate,
    };

    // Conditionally add serviceId if it's not null
    if (serviceId != null) {
      jsonMap['service_id'] = serviceId;
    }

    return jsonMap;
  }
}
