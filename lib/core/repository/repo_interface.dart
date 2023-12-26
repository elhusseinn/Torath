import 'package:dartz/dartz.dart';
import 'package:torath/core/error/failures.dart';
import 'package:torath/models/filters/get_all_places_times_response.dart';
import 'package:torath/models/getMahfal/get_mahfal_request.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

abstract class IRepository {
  Future<Either<Failure, GetMahfalResponse>> getMahfal(
      {required GetMahfalRequest request});

  Future<Either<Failure, GetAllPlacesTimesResponse>> getPlacesTimes(
      {required GetMahfalRequest request});
}
