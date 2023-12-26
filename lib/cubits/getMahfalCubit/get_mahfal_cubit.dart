import 'package:bloc/bloc.dart';
import 'package:torath/core/repository/repo_interface.dart';
import 'package:torath/models/getMahfal/get_mahfal_request.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

import 'get_mahfal_state.dart';

class GetMahfalCubit extends Cubit<GetMahfalState> {
  GetMahfalCubit(this.repo) : super(GetMahfalInitialState());

  IRepository repo;

  void getMahfal(
      {required String surah,
      List<String>? places,
      List<String>? times}) async {
    emit(GetMahfalLoadingState());
    String? placesQuery;
    String? timesQuery;
    places != null && places.isNotEmpty? placesQuery = places.join(','):null;
    times != null && times.isNotEmpty? timesQuery = times.join(','):null;

    GetMahfalRequest request = GetMahfalRequest(surahName: surah, places: placesQuery, times: timesQuery);

    var res = await repo.getMahfal(request: request);

    res.fold((l) => emit(GetMahfalErrorState(l.message)),
        (r) => emit(GetMahfalSuccessState(r)));
  }
}
