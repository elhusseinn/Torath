import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/repository/repo_interface.dart';
import 'get_all_places_times_state.dart';

class GetAllPlacesCubit extends Cubit<GetAllPlacesState> {
  GetAllPlacesCubit(this.repo) : super(GetAllPlacesInitialState());
  IRepository repo;

  void getPlacesTimes(String surahName) async {
    // emit(GetAllPlacesLoadingState());

    Map<String, String> params = {
      "select": "place,time_year",
      "surah": "eq.$surahName"
    };

    // var res = await repo.getPlacesTimes(params: params);

    // res.fold((l) => emit(GetAllPlacesErrorState(l.message)),
    //     (r) => emit(GetAllPlacesSuccessState(r)));
  }
}
