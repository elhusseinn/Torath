class ServerException implements Exception {
  final String msg;
  const ServerException(this.msg);

  @override
  String toString() {
    return msg;
  }
}

class UnAuthorizedException implements Exception {}

class OnboardOpenedException implements Exception {}

class NetworkException implements Exception {}

class ValidationException implements Exception {}

class NotCachedException implements Exception {}

class GeneralException implements Exception {
  final String msg;
  const GeneralException(this.msg);

  @override
  String toString() {
    return msg;
  }
}
