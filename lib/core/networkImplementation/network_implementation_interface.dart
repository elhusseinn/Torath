import 'package:torath/models/getMahfal/get_mahfal_response.dart';

abstract class INetworkManager {
  Future<GetMahfalResponse> getMahfal(
      {required Map<String, String> params, Map<String, String>? otherHeaders});
}
