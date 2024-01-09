import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:torath/core/language/text.dart';
import 'package:torath/core/utils/assets_catalog.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_cubit.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_state.dart';
import 'package:torath/screens/audioPlayer/widgets/mini_audio_player.dart';

class BottomNavBar extends StatefulWidget {
  int? selected;
  Function onSelect;
  BottomNavBar({this.selected, required this.onSelect, super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool _miniMediaPlayerVisible = false;
  double _stackHeight = kBottomNavigationBarHeight;
  void _showOverlay(BuildContext context) async {
    print("OVERLAY");
    // Declaring and Initializing OverlayState
    // and OverlayEntry objects
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
        builder: (context) {
          // You can return any widget you like here
          // to be displayed on the Overlay
          return Positioned(
            bottom: 0,
            child: Material(
              child: Container(
                height: 50.h,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Center(child: Text("test")),
              ),
            ),
          );
        },
        opaque: true);

    // Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayEntry);
    // Awaiting for 3 seconds
    await Future.delayed(Duration(seconds: 3));

    // Removing the OverlayEntry from the Overlay
    overlayEntry.remove();
  }

  void _minimizedMediaPlayerOn() {
    if(_miniMediaPlayerVisible) return;
    setState(() {
      _miniMediaPlayerVisible = true;
      _stackHeight += (90.h - 7);
    });
  }

  void _minimizedMediaPlayerOff() {
    setState(() {
      _miniMediaPlayerVisible = false;
      _stackHeight -= (90.h);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 80.h,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x1C898989),
            blurRadius: 4,
            offset: Offset(0, -4),
            spreadRadius: 0,
          )
        ],
      ),
      child: _buildNewBottomNavBar(),
    );
  }

  Widget _buildNewBottomNavBar() {
    return BlocListener<AudioManagementCubit, AudioManagementState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is SuccessAudioLoadingState) {
          _minimizedMediaPlayerOn();
        } else {
          _minimizedMediaPlayerOn();
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          // color: Colors.red,
          color:const Color(0xFFD0D9D0),
          height: _stackHeight + 7,
          child: Stack(
            children: [
              Visibility(
                visible: _miniMediaPlayerVisible,
                child: const Positioned(
                  bottom: kBottomNavigationBarHeight,
                  left: 0,
                  right: 0,
                  child:MiniAudioPlayer(),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: const Color(0xFF4A6848),
                  padding: EdgeInsets.only(top: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavBarItem(
                          icon: AssetsCatalog.navBarHomeIcon,
                          label: ArabicText.mainHome,
                          index: 0),
                      _buildNavBarItem(
                          icon: AssetsCatalog.favIcon,
                          label: ArabicText.favourite,
                          index: 1),
                      _buildNavBarItem(
                          icon: AssetsCatalog.seraIcon,
                          label: ArabicText.sera,
                          index: 2),
                      _buildNavBarItem(
                          icon: AssetsCatalog.contactUsIcon,
                          label: ArabicText.contactUs,
                          index: 3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavBarItem(
      {required String icon, required String label, required int index}) {
    return InkWell(
      onTap: () {
        widget.onSelect(index);
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.0599,
        child: Column(
          children: [
            SvgPicture.asset(icon,
                width: 25.w,
                height: 25.h,
                color: widget.selected == index
                    ? const Color(0xFF224520)
                    : const Color(0xFFD9D9D9)),
            Container(
              margin: EdgeInsets.only(top: 3.h),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.selected == index
                      ? const Color(0xFF224520)
                      : const Color(0xFFD9D9D9),
                  fontSize: 13.sp,
                  fontFamily: 'IBM Plex Sans',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomNavigationBar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedItemColor: const Color(0xFF224520),
        unselectedItemColor: const Color(0xFFD9D9D9),
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsCatalog.navBarHomeIcon,
                  width: 25.w,
                  height: 25.h,
                  color: widget.selected == 0
                      ? const Color(0xFF224520)
                      : const Color(0xFFD9D9D9)),
              label: ArabicText.mainHome),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsCatalog.favIcon,
                  width: 25.w,
                  height: 25.h,
                  color: widget.selected == 1
                      ? const Color(0xFF224520)
                      : const Color(0xFFD9D9D9)),
              label: ArabicText.favourite),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsCatalog.seraIcon,
                  width: 25.w,
                  height: 25.h,
                  color: widget.selected == 2
                      ? const Color(0xFF224520)
                      : const Color(0xFFD9D9D9)),
              label: ArabicText.sera),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AssetsCatalog.contactUsIcon,
                  width: 25.w,
                  height: 25.h,
                  color: widget.selected == 3
                      ? const Color(0xFF224520)
                      : const Color(0xFFD9D9D9)),
              label: ArabicText.contactUs),
        ],
        onTap: (index) {
          widget.onSelect(index);
        },
        backgroundColor: const Color(0xFF4A6848),
      ),
    );
  }
}
