// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:torath/core/utils/assets_catalog.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_cubit.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_state.dart';
import 'package:torath/models/DAOs/audio_player_dao.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:torath/screens/audioPlayer/widgets/control_buttons.dart';

import '../../models/DAOs/position_data.dart';

class AudioPlayerScreen extends StatefulWidget {
  AudioPlayerDao audio;

  AudioPlayerScreen({super.key, required this.audio}) {
    print(audio.link);
  }

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AudioManagementCubit>().startAudio(widget.audio);
  }

  @override
  Widget build(BuildContext context) {
    final player = context.read<AudioManagementCubit>().getAudioPlayer();
    Stream<PositionData> positionDataStream =
        context.read<AudioManagementCubit>().getPositionDataStream();
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
            BlocProvider.value(
              value: BlocProvider.of<AudioManagementCubit>(context),
              child: BlocBuilder<AudioManagementCubit, AudioManagementState>(
                builder: (context, state) {
                  print(state.toString() + " AudioStatE");
                  return AudioControlButtons(
                    player: player,
                    positionDataStream: positionDataStream,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
