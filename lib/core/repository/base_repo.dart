import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../error/exceptions.dart';
import '../error/failures.dart';
import '../network/network_info.dart';

abstract class BaseRepository {
  INetworkInfo networkInfo;

  BaseRepository(
    this.networkInfo,
  );

  Future<Either<Failure, T>> handleGeneralException<T>(
      Future<T> Function() fun) async {
    return networkInfo.ifConnectedOrReturnFailure<T>(
      () async {
        return handleException(fun);
      },
    );
  }

  Future<Either<Failure, T>> callDataSourceWithNoInternetCheck<T>(
      Future<T> Function() fun) async {
    return handleException(fun);
  }

  Future<Either<Failure, T>> repoCaching<T>(
      Future<T> Function() fun1, Future<T> Function() fun2) async {
    return networkInfo.isConnectedToServer(() {
      if (kDebugMode) {
        // loggy.info("return from remote data source");
      }
      return handleException(fun1);
    }, () {
      if (kDebugMode) {
        //loggy.info("return from local data source");
      }
      return handleException(fun2);
    });
  }

  Future<Either<Failure, T>> handleException<T>(
      Future<T> Function() fun) async {
    try {
      if (kDebugMode) {
        //loggy.info("");
      }
      return Right(await fun());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on UnAuthorizedException {
      return Left(UnAuthorizedFailure("UnAuthorizedFailure"));
    } on OnboardOpenedException {
      return Left(OnboardOpenedFailure("OnboardOpenedFailure"));
    } on NetworkException {
      return Left(NetworkFailure("NETWORK_FAILURE"));
    } catch (e) {
      if (kDebugMode) {
        //loggy.error(e.runtimeType);
      }
      print(e.toString());
      return Left(GeneralFailure("GeneralFailure"));
    }
  }

// Future<Either<Failure, T>> handleCustomException<T>(
//     Future<Either<Failure, T>> Function() fun) async {
//   return networkInfo.ifConnectedOrReturnFailure<T>(
//     () async {
//       try {
//         loggy.info("");
//         return await fun();
//       } on ServerException catch {
//         return Left(ServerFailure());
//       } on UnAuthorizedException {
//         return Left(UnAuthorizedFailure());
//       } catch (e) {
//         loggy.error(e.runtimeType);
//         return Left(GeneralFailure());
//       }
//     },
//   );
// }
}
