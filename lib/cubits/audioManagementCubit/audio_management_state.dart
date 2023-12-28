import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

abstract class AudioManagementState extends Equatable {
  const AudioManagementState();
}

class NoAudioRunningState extends AudioManagementState {
  @override
  List<Object> get props => [];
}

class AudioEncodingErrorState extends AudioManagementState {
  String? message;
  AudioEncodingErrorState(this.message);

  @override
  List<Object> get props => [];
}

class LoadingAudioState extends AudioManagementState {
  @override
  List<Object> get props => [];
}

class SuccessAudioLoadingState extends AudioManagementState {
  @override
  List<Object> get props => [];
}

class PlayingAudioState extends AudioManagementState {
  @override
  List<Object> get props => [];
}

class PausedAudioState extends AudioManagementState {
  @override
  List<Object> get props => [];
}

class EndedAudioState extends AudioManagementState {


  @override
  List<Object> get props => [];
}
