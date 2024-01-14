import 'package:flutter_bloc/flutter_bloc.dart';

import 'mini_player_management_state.dart';

class MiniPlayerManagementCubit extends Cubit<MiniPlayerManagementState> {
  MiniPlayerManagementCubit() : super(MiniPlayerManagementInitialState());

  void emitMiniPlayerInitialState(){
    emit(MiniPlayerManagementInitialState());
  }
  void emitMiniPlayerAudioChanged(){
    emit(MiniPlayerManagementAudioChangedState());

  }
}
