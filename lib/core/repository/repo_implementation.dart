import 'package:dartz/dartz.dart';

import 'package:torath/core/error/failures.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

import '../networkImplementation/network_implementation_interface.dart';
import 'base_repo.dart';
import 'repo_interface.dart';
import '../networkImplementation/network_implementation.dart';

class Repository extends BaseRepository implements IRepository {
  Repository(super.networkInfo);
  INetworkManager network = NetworkManager();

  @override
  Future<Either<Failure, GetMahfalResponse>> getMahfal(
      {required Map<String, String> params,
      Map<String, String>? otherHeaders}) {
    return handleGeneralException(
        () => network.getMahfal(params: params, otherHeaders: otherHeaders));
  }
}
