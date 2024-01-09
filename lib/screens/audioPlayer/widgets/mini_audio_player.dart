import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_cubit.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_state.dart';
import 'package:torath/models/DAOs/audio_player_dao.dart';

import '../../../core/utils/assets_catalog.dart';
import '../../../core/utils/routes_catalog.dart';

class MiniAudioPlayer extends StatefulWidget {
  const MiniAudioPlayer({super.key});

  @override
  State<MiniAudioPlayer> createState() => _MiniAudioPlayerState();
}

class _MiniAudioPlayerState extends State<MiniAudioPlayer> {
  final AudioPlayerDao _audioPlayer =
      PreferenceManager().audioManagementCubit.getAudioMetaData();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _audioPlayer.miniPlayerOpened = true;
        Navigator.of(context)
            .pushNamed(RoutesCatalog.audioPlayer, arguments: _audioPlayer);
      },
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.8509804010391235),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 13.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'playerAvatar',
                child: Image.asset(
                  AssetsCatalog.miniPlayerImage,
                  height: 55.68.h,
                  width: 58.74.w,
                ),
              ),
              Column(
                children: [
                  Text(
                    'سورة ${_audioPlayer.surahName}',
                    style: TextStyle(
                      color: const Color(0xFF4F4C4C),
                      fontSize: 32.sp,
                      fontFamily: 'IBM Plex Sans',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '${_audioPlayer.place} - ${_audioPlayer.time}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.sp,
                      fontFamily: 'IBM Plex Sans',
                      fontWeight: FontWeight.w400,
                      height: 0.8.h,
                    ),
                  ),
                ],
              ),
              BlocConsumer<AudioManagementCubit, AudioManagementState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  if (state is PausedAudioState ||
                      state is SuccessAudioLoadingState) {
                    return GestureDetector(
                      onTap: () {
                        context.read<AudioManagementCubit>().playAudio();
                      },
                      child: SvgPicture.asset(
                        AssetsCatalog.playIcon,
                      ),
                    );
                  } else if (state is PlayingAudioState) {
                    return GestureDetector(
                      onTap: () {
                        context.read<AudioManagementCubit>().pauseAudio();
                      },
                      child: SvgPicture.asset(
                        AssetsCatalog.miniPlayerPauseButton,
                      ),
                    );
                  } else if (state is CompletedAudioState ||
                      state is EndedAudioState) {
                    return GestureDetector(
                      onTap: () {
                        context.read<AudioManagementCubit>().restartAudio();
                      },
                      child: SvgPicture.asset(
                        AssetsCatalog.replayButton,
                        height: 30.h,
                        width: 30.w,
                      ),
                    );
                  } else if (state is LoadingAudioState) {
                    return Container(
                      margin: EdgeInsets.all(8.0.h),
                      width: 30.0.w,
                      height: 30.0.h,
                      child: const CircularProgressIndicator(
                        color: Color(0xFF4A6848),
                      ),
                    );
                  }
                  return SizedBox(
                    height: 30.h,
                    width: 30.w,
                    child: const Icon(Icons.error_outline_rounded),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
