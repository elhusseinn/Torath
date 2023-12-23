import 'package:bloc/bloc.dart';
import 'package:torath/core/repository/repo_interface.dart';

import 'get_mahfal_state.dart';

class GetMahfalCubit extends Cubit<GetMahfalState> {
  GetMahfalCubit(this.repo) : super(GetMahfalInitialState());

  IRepository repo;

  void getMahfal(
      {required String surah, String? place, String? time, int? page}) async {
    emit(GetMahfalLoadingState());
    Map<String, String>? otherHeaders;
    Map<String, String> params = {
      "select": "*",
      "surah": "eq.$surah",
    };

    place != null
        ? params.addAll(
            {"place": "eq.$place"},
          )
        : null;
    time != null
        ? params.addAll(
            {"place": "eq.$time"},
          )
        : null;
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
