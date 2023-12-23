import 'package:torath/core/networkImplementation/network_implementation_interface.dart';
import 'package:torath/core/utils/urls.dart';
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

    print("test");
    print(res.toString());
    return GetMahfalResponse.fromJson(res);
  }
}
