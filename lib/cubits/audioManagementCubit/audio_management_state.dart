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

  LoadingAudioState() {
    print("LoadingAudioState");
  }
}

class SuccessAudioLoadingState extends AudioManagementState {
  @override
  List<Object> get props => [];

  SuccessAudioLoadingState() {
    print("SuccessAudioLoadingState");
  }
}

class PlayingAudioState extends AudioManagementState {
  @override
  List<Object> get props => [];

  PlayingAudioState() {
    print("PlayingAudioState");
  }
}

class PausedAudioState extends AudioManagementState {
  @override
  List<Object> get props => [];

  PausedAudioState() {
    print("PausedAudioState");
  }
}
class CompletedAudioState extends AudioManagementState {
  @override
  List<Object> get props => [];

  CompletedAudioState() {
    print("CompletedAudioState");
  }
}

class EndedAudioState extends AudioManagementState {
  @override
  List<Object> get props => [];

  EndedAudioState() {
    print("EndedAudioState");
  }
}
