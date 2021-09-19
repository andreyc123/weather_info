class ApiException implements Exception {
  final int? statusCode;
  final String message;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() {
    var result = message;
    if (statusCode != null) {
      result += ": statusCode=$statusCode";
    }
    return result;
  }
}

class ServerApiException extends ApiException {
  ServerApiException(String message, int statusCode) : super(message, statusCode);
}

class NetworkApiException extends ApiException {
  NetworkApiException(String message) : super(message);
}