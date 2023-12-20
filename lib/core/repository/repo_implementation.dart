import 'package:dartz/dartz.dart';

import 'package:torath/core/error/failures.dart';

import '../networkImplementation/network_implementation_interface.dart';
import 'base_repo.dart';
import 'repo_interface.dart';
import '../networkImplementation/network_implementation.dart';

class Repository extends BaseRepository implements IRepository {
  Repository(super.networkInfo);
  INetworkManager network = NetworkManager();

  @override
  Future<Either<Failure, dynamic>> getMahafel(
      {required Map<String, String> params}) {
    return handleGeneralException(() => network.getMahafel(params: params));
  }
}