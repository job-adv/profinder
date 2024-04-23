enum ErrorType { CONNECTIVITY, DATA }

class ErrorPayload {
  final ErrorType type;

  ErrorPayload(this.type);
}
