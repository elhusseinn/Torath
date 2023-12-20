import 'package:dartz/dartz.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import '../error/failures.dart';

abstract class INetworkInfo {
  Future<bool> get isConnected;
  Future<Either<Failure, T>> ifConnectedOrReturnFailure<T>(
      Future<Either<Failure, T>> Function() fun);

  Future<Either<Failure, T>> isConnectedToServer<T>(
      Future<Either<Failure, T>> Function() fun1,
      Future<Either<Failure, T>> Function() fun2);
}


class NetworkInfo  implements INetworkInfo {
  final DataConnectionChecker con;
  NetworkInfo({required this.con});
  @override
  Future<bool> get isConnected => con.hasConnection;

  @override
  Future<Either<Failure, T>> ifConnectedOrReturnFailure<T>(
      Future<Either<Failure, T>> Function() fun) async {
    if (await isConnected) {
      //if (true) {
      return fun();
    } else {
      return Left(NetworkFailure("NetworkFailure"));
    }
  }

  @override
  Future<Either<Failure, T>> isConnectedToServer<T>(
      Future<Either<Failure, T>> Function() fun1,
      Future<Either<Failure, T>> Function() fun2) async {
    if (await isConnected) {
      //if (true) {
      return fun1();
    } else {
      return fun2();
    }
  }
}
