

import 'package:equatable/equatable.dart';

abstract class MiniPlayerManagementState extends Equatable {
  const MiniPlayerManagementState();
}

class MiniPlayerManagementInitialState extends MiniPlayerManagementState {
  @override
  List<Object> get props => [];
}
class MiniPlayerManagementAudioChangedState extends MiniPlayerManagementState {
  @override
  List<Object> get props => [];
}
