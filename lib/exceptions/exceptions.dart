class NotFoundException implements Exception {
  final dynamic message;

  NotFoundException([this.message]);

  String toString() {
    Object message = this.message;
    if (message == null) return "NotFoundException";
    return "NotFoundException: $message";
  }
}

class UnAuthorisedException implements Exception {
  final dynamic message;

  UnAuthorisedException([this.message]);

  String toString() {
    Object message = this.message;
    if (message == null) return "${(UnAuthorisedException).toString()}";
    return "${(UnAuthorisedException).toString()}: $message";
  }
}

class UnknownException implements Exception {
  final dynamic message;

  UnknownException([this.message]);

  String toString() {
    Object message = this.message;
    if (message == null) return "UnknownException";
    return "UnknownException: $message";
  }
}

class ServerErrorException implements Exception {
  var cause;

  ServerErrorException([this.cause]);

  @override
  String toString() {
    return "${(ServerErrorException).toString()}: $cause";
  }
}

class UserExistException implements Exception {
  var cause;

  UserExistException([this.cause]);

  @override
  String toString() {
    return "${(UserExistException).toString()}: $cause";
  }
}

class InvalidTokenException implements Exception {
  var cause;

  InvalidTokenException([this.cause]);

  @override
  String toString() {
    return "${(InvalidTokenException).toString()}: $cause";
  }
}

class InvalidCodeException implements Exception {
  var cause;

  InvalidCodeException([this.cause]);

  @override
  String toString() {
    return "${(InvalidCodeException).toString()}: $cause";
  }
}

class InvalidLoginPasswordException implements Exception {
  var cause;

  InvalidLoginPasswordException([this.cause]);

  @override
  String toString() {
    return "${(InvalidLoginPasswordException).toString()}: $cause";
  }
}

