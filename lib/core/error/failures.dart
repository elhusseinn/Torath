import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  String message;
  Failure(this.message);
  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  NetworkFailure(super.message);
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure(super.message);
}

class GeneralFailure extends Failure {
  GeneralFailure(super.message);
}

class OnboardOpenedFailure extends Failure {
  OnboardOpenedFailure(super.message);
}

