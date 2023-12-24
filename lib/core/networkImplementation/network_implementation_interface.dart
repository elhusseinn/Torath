import 'package:torath/models/filters/get_all_places_times_response.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

abstract class INetworkManager {
  Future<GetMahfalResponse> getMahfal(
      {required Map<String, String> params, Map<String, String>? otherHeaders});

  Future<GetAllPlacesTimesResponse> getTimesPlaces(
      {required Map<String, String> params});
}
