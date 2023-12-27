// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:torath/core/utils/assets_catalog.dart';
import 'package:torath/models/DAOs/audio_player_dao.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:torath/screens/audioPlayer/widgets/control_buttons.dart';

class AudioPlayerScreen extends StatefulWidget {
  AudioPlayerDao audio;
  AudioPlayerScreen({super.key, required this.audio}) {
    print(audio.link);
  }

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen>
    with WidgetsBindingObserver {
  final _player = AudioPlayer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    });
    // Try to load audio from a source and catch any errors.
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(
        Uri.parse(widget.audio.link),
        tag: MediaItem(
          id: widget.audio.link,
          title:
              'سورة ${widget.audio.surahName}\n${widget.audio.place} - ${widget.audio.time}',
          artist: "مصطفي اسماعيل",
          // artUri: Uri.parse("file://assets/images/audio_player_image.png"),
        ),
      ));
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "لا يمكن تشغيل هذه التلاوه برجاء المحاوله مره اخري او التواصل مع الدعم")));
      print("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // Release the player's resources when not in use. We use "stop" so that
      // if the app resumes later, it will still remember what position to
      // resume from.
      _player.stop();
    }
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color(0xFFD0D9D0),
        padding: EdgeInsets.symmetric(vertical: 88.h, horizontal: 29.w),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 89.h),
              child: GestureDetector(
                child: SvgPicture.asset(AssetsCatalog.closePlayerIcon),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 12.h),
              child: Image.asset(AssetsCatalog.audioPlayerImage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(AssetsCatalog.favouriteIcon),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'مصطفي إسماعيل\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Amiri',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text:
                              'سورة ${widget.audio.surahName}\n${widget.audio.place} - ${widget.audio.time}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'Amiri',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SvgPicture.asset(AssetsCatalog.downloadIcon)
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.h),
              child: StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return ProgressBar(
                    thumbCanPaintOutsideBar: false,
                    thumbGlowRadius: 0,
                    thumbRadius: 5,
                    barCapShape: BarCapShape.square,
                    baseBarColor: Colors.white,
                    timeLabelPadding: 10,
                    progress: positionData?.position ?? Duration.zero,
                    buffered: positionData?.bufferedPosition ?? Duration.zero,
                    total: positionData?.duration ?? Duration.zero,
                    onSeek: _player.seek,
                  );
                },
              ),
            ),
            AudioControlButtons(player: _player)
          ],
        ),
      ),
    );
  }
}

class PositionData {
  Duration position;
  Duration bufferedPosition;
  Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
