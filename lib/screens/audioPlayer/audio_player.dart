// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:torath/core/utils/assets_catalog.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_cubit.dart';
import 'package:torath/cubits/miniPlayerManagementCubit/mini_player_management_cubit.dart';
import 'package:torath/models/DAOs/audio_player_dao.dart';
import 'package:torath/screens/audioPlayer/widgets/control_buttons.dart';

import '../../models/DAOs/position_data.dart';

class AudioPlayerScreen extends StatefulWidget {
  AudioPlayerDao audio;

  AudioPlayerScreen({super.key, required this.audio,}) {
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
    if(widget.audio.miniPlayerOpened != null){
      if(widget.audio.miniPlayerOpened!){
        return;
      }
    }
    context.read<AudioManagementCubit>().startAudio(widget.audio);
    context.read<MiniPlayerManagementCubit>().emitMiniPlayerAudioChanged();
    context.read<MiniPlayerManagementCubit>().emitMiniPlayerInitialState();
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
              child: Hero(
                tag: 'playerAvatar',
                  child: Image.asset(AssetsCatalog.audioPlayerImage)),
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
              child: AudioControlButtons(
                player: player,
                positionDataStream: positionDataStream,
              ),
            )
          ],
        ),
      ),
    );
  }
}
