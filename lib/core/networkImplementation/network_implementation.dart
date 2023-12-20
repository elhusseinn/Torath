import 'package:torath/core/networkImplementation/network_implementation_interface.dart';
import 'package:torath/core/utils/urls.dart';

import '../network/network.dart';
import '../network/network_client.dart';

class NetworkManager extends INetworkManager {
  Network networkClient = Network(networkClient: NetworkClient());

  @override
  Future getMahafel({required Map<String, String> params}) async{
    var res = await networkClient.get(Urls.mahafel, params: params);
    return res.toString();
  }


}
