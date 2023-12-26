import 'package:torath/models/filters/get_all_places_times_response.dart';
import 'package:torath/models/getMahfal/get_mahfal_request.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

abstract class INetworkManager {
  Future<GetMahfalResponse> getMahfal(
      {required GetMahfalRequest request});

  Future<GetAllPlacesTimesResponse> getTimesPlaces(
      {required GetMahfalRequest request});
}
