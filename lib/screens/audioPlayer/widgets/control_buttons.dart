import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:torath/core/utils/assets_catalog.dart';

class AudioControlButtons extends StatefulWidget {
  final AudioPlayer player;
  const AudioControlButtons({super.key, required this.player});

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
                widget.player.seek(
                    widget.player.position - const Duration(seconds: 10));
              },
              child: SvgPicture.asset(AssetsCatalog.seekBackward10),
            ),
            Container(
              child: isPlaying
                  ? GestureDetector(
                      onTap: () {
                        widget.player.pause();
                      },
                      child: SvgPicture.asset(AssetsCatalog.pauseButton),
                    )
                  : GestureDetector(
                      onTap: () {
                        widget.player.play();
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
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: StreamBuilder<PlayerState>(
        stream: widget.player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
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
            return GestureDetector(
              onTap: () {
                widget.player.seek(Duration.zero);
              },
              child: SvgPicture.asset(AssetsCatalog.replayButton),
            );
          }
        },
      ),
    );
  }
}
