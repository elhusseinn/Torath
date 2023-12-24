import 'package:torath/core/networkImplementation/network_implementation_interface.dart';
import 'package:torath/core/utils/urls.dart';
import 'package:torath/models/filters/get_all_places_times_response.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

import '../network/network.dart';
import '../network/network_client.dart';

class NetworkManager extends INetworkManager {
  Network networkClient = Network(networkClient: NetworkClient());

  @override
  Future<GetMahfalResponse> getMahfal(
      {required Map<String, String> params,
      Map<String, String>? otherHeaders}) async {
    var res = await networkClient.get(Urls.mahafel,
        params: params, otherHeaders: otherHeaders);
    return GetMahfalResponse.fromJson(res);
  }

  @override
  Future<GetAllPlacesTimesResponse> getTimesPlaces({required Map<String, String> params}) async{
    var res = await networkClient.get(Urls.mahafel, params: params);
    return GetAllPlacesTimesResponse.fromJson(res);
  }
}
