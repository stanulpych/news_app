abstract class Failure {
  final String message;
  Failure(this.message);
}

class ApiFailure extends Failure {
  final String code;
  ApiFailure({required this.code, required String message}) : super(message);
}

class TimeoutFailure extends Failure {
  TimeoutFailure() : super('Request timed out');
}

class NoConnectionFailure extends Failure {
  NoConnectionFailure() : super('No internet connection');
}

class UnknownFailure extends Failure {
  UnknownFailure(String message) : super(message);
}
