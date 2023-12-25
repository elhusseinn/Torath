import 'package:bloc/bloc.dart';
import 'package:torath/core/repository/repo_interface.dart';
import 'package:torath/models/getMahfal/get_mahfal_response.dart';

import 'get_mahfal_state.dart';

class GetMahfalCubit extends Cubit<GetMahfalState> {
  GetMahfalCubit(this.repo) : super(GetMahfalInitialState());

  IRepository repo;

  void getMahfal(
      {required String surah,
      List<String>? places,
      List<String>? times,
      int? page}) async {
    emit(GetMahfalLoadingState());
    Map<String, String>? otherHeaders;
    Map<String, String> params = {
      "select": "*",
      "surah": "eq.$surah",
    };
    if (places != null && times != null) {
      GetMahfalResponse response = GetMahfalResponse();
      String x = places.join(',');
      params.addAll(
        {"place": "in.($x)"},
      );
      var resPlaces =
          await repo.getMahfal(params: params, otherHeaders: otherHeaders);
      resPlaces.fold(
          (l) => emit(GetMahfalErrorState(l.message)), (r) => response = r);
      String y = times.join(',');
      params.clear();
      params.addAll(
        {"time_year": "in.($y)"},
      );
      var resTimes =
          await repo.getMahfal(params: params, otherHeaders: otherHeaders);
      resTimes.fold((l) => emit(GetMahfalErrorState(l.message)), (r) {
        response.data!.addAll(r.data!);
      });
      emit(GetMahfalSuccessState(response));
      return;
    } else {
      if (places != null) {
        String x = places.join(',');
        params.addAll(
          {"place": "in.($x)"},
        );
      }
      if (times != null) {
        String x = times.join(',');
        params.addAll(
          {"time_year": "in.($x)"},
        );
      }
    }

    if (page != null) {
      final int start = (page - 1) * 20;
      final int end = start + 20;
      otherHeaders = {"Range": "$start-$end"};
    }

    var res = await repo.getMahfal(params: params, otherHeaders: otherHeaders);
    res.fold((l) => emit(GetMahfalErrorState(l.message)),
        (r) => emit(GetMahfalSuccessState(r)));
  }
}
