import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:torath/core/utils/assets_catalog.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_cubit.dart';

import '../../../models/DAOs/position_data.dart';

class AudioControlButtons extends StatefulWidget {
  final AudioPlayer player;
  Stream<PositionData> positionDataStream;
  AudioControlButtons(
      {super.key, required this.positionDataStream, required this.player});

  @override
  State<AudioControlButtons> createState() => _AudioControlButtonsState();
}

class _AudioControlButtonsState extends State<AudioControlButtons> {
  Widget _buildRowButtons(bool isPlaying) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                widget.player
                    .seek(widget.player.position - const Duration(seconds: 10));
              },
              child: SvgPicture.asset(AssetsCatalog.seekBackward10),
            ),
            Container(
              child: isPlaying
                  ? GestureDetector(
                      onTap: () {
                        context.read<AudioManagementCubit>().pauseAudio();
                        // widget.player.pause();
                      },
                      child: SvgPicture.asset(AssetsCatalog.pauseButton),
                    )
                  : GestureDetector(
                      onTap: () {
                        context.read<AudioManagementCubit>().playAudio();
                        // widget.player.play();
                      },
                      child: SvgPicture.asset(AssetsCatalog.playButton),
                    ),
            ),
            GestureDetector(
                onTap: () {
                  widget.player.seek(
                      widget.player.position + const Duration(seconds: 10));
                },
                child: SvgPicture.asset(AssetsCatalog.seekForward10)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.h),
          child: StreamBuilder<PositionData>(
            stream: widget.positionDataStream,
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
                onSeek: widget.player.seek,
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: StreamBuilder<PlayerState>(
            stream: widget.player.playerStateStream,
            builder: (context, snapshot) {
              final playerState = snapshot.data;
              final processingState = playerState?.processingState;
              final playing = playerState?.playing;
              if (processingState == ProcessingState.loading ||
                  processingState == ProcessingState.buffering) {
                context.read<AudioManagementCubit>().emitAudioLoadingState();
                return Container(
                  margin: EdgeInsets.all(8.0.h),
                  width: 30.0.w,
                  height: 30.0.h,
                  child: const CircularProgressIndicator(
                    color: Color(0xFF4A6848),
                  ),
                );
              } else if (playing != true) {
                return _buildRowButtons(false);
              } else if (processingState != ProcessingState.completed) {
                return _buildRowButtons(true);
              } else {
                context.read<AudioManagementCubit>().endAudio();
                return GestureDetector(
                  onTap: () {
                    widget.player.seek(Duration.zero);
                  },
                  child: SvgPicture.asset(AssetsCatalog.replayButton),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
