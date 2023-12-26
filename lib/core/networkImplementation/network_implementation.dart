import 'package:torath/core/networkImplementation/network_implementation_interface.dart';
import 'package:torath/core/utils/urls.dart';
import 'package:torath/models/filters/get_all_places_times_response.dart';
import 'package:torath/models/getMahfal/get_mahfal_request.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

import '../network/network.dart';
import '../network/network_client.dart';

class NetworkManager extends INetworkManager {
  Network networkClient = Network(networkClient: NetworkClient());

  @override
  Future<GetMahfalResponse> getMahfal(
      {required GetMahfalRequest request}) async {
    var res = await networkClient.post(Urls.mahafel, data: request.toJson());
    return GetMahfalResponse.fromJson(res);
  }

  @override
  Future<GetAllPlacesTimesResponse> getTimesPlaces(
      {required GetMahfalRequest request}) async {
    var res = await networkClient.post(Urls.mahafel, data: request.toJson());
    return GetAllPlacesTimesResponse.fromJson(res);
  }
}
