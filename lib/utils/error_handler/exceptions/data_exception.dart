class DataException implements Exception {
  final String message;

  DataException([this.message = "can't fetch data"]);

  @override
  String toString() {
    return "Error: $message";
  }
}
