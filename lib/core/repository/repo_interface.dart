import 'package:dartz/dartz.dart';
import 'package:torath/core/error/failures.dart';

abstract class IRepository {
  Future<Either<Failure, dynamic>> getMahafel({required Map<String, String> params});
}
