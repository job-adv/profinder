class Price {
  final int? priceId;
  final String? value;
  final String? description;
  final String? rate;

  Price({
    required this.priceId,
    required this.value,
    required this.description,
    required this.rate,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      priceId: json['price_id'],
      value: json['value'], // Parse value as an integer
      description: json['description'],
      rate: json['rate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'price_id': priceId,
      'value': value,
      'description': description,
    };
  }
}
