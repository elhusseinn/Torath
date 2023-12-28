import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/DAOs/audio_player_dao.dart';
import '../../models/DAOs/position_data.dart';
import 'audio_management_state.dart';

class AudioManagementCubit extends Cubit<AudioManagementState>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();

  AudioManagementCubit() : super(NoAudioRunningState()) {
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {
    // Inform the operating system of our app's audio attributes etc.
    // We pick a reasonable default for an app that plays speech.
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
      emit(AudioEncodingErrorState(e.toString()));
    }, onDone: () {
      // WidgetsBinding.instance.removeObserver(this);
      // emit(EndedAudioState(_player));
    });
  }

  void startAudio(AudioPlayerDao audio) async {
    emit(LoadingAudioState());
    // Try to load audio from a source and catch any errors.
    try {
      await _player.setAudioSource(
        AudioSource.uri(
          Uri.parse(audio.link),
          tag: MediaItem(
            id: audio.link,
            title: 'سورة ${audio.surahName}\n${audio.place} - ${audio.time}',
            artist: "مصطفي إسماعيل",
            artUri: Uri.parse(
                "https://th.bing.com/th/id/R.f366a92082b833807a7f7943f1f55c91?rik=EMjTvENQZQd1cA&pid=ImgRaw&r=0&sres=1&sresct=1"),
          ),
        ),
      );
      emit(SuccessAudioLoadingState());
    } catch (e) {
      // Navigator.of(context).pop();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(
      //         "لا يمكن تشغيل هذه التلاوه برجاء المحاوله مره اخري او التواصل مع الدعم"),
      //   ),
      // );
      print("Error loading audio source: $e");
      emit(AudioEncodingErrorState(e.toString()));
    }
  }

  void playAudio() {
    emit(PlayingAudioState());
    _player.play();
  }

  void pauseAudio() {
    emit(PausedAudioState());
    _player.pause();
  }

  void stopAudio() {
    _player.stop();
  }

  void endAudio() {
    emit(EndedAudioState());
  }

  void overrideAudio(AudioPlayerDao audio) {
    _player.stop();
    startAudio(audio);
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Future<void> close() {
    _player.dispose();
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
}
