import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String message;
  Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}

class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure(String message) : super(message);
}

class GeneralFailure extends Failure {
  GeneralFailure(String message) : super(message);
}

class OnboardOpenedFailure extends Failure {
  OnboardOpenedFailure(String message) : super(message);
}

