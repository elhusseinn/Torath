import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/commonWidgets/homeScreen/app_bar.dart';
import 'package:torath/core/commonWidgets/homeScreen/bottom_navigation_bar.dart';
import 'package:torath/cubits/audioManagementCubit/audio_management_cubit.dart';
import 'package:torath/cubits/miniPlayerManagementCubit/mini_player_management_cubit.dart';
import 'package:torath/screens/homeScreen/home_screen.dart';
import 'package:torath/screens/seraScreen/sera_screen.dart';

import '../../core/utils/globals.dart';
import '../../core/utils/routes_catalog.dart';
import '../contactUsScreen/contact_us_screen.dart';
import '../favouritesScreen/favourite_screen.dart';

class HomeTabs extends StatefulWidget {
  int? selectedPage;

  HomeTabs({this.selectedPage, super.key});

  @override
  State<HomeTabs> createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> with WidgetsBindingObserver {
  late int _page;

  @override
  void initState() {
    _page = widget.selectedPage != null ? widget.selectedPage! : 0;
    super.initState();
  }

  // int _page = 0;

  void onSelect(index) {
    setState(() {
      _page = index;
      // Navigator.pushNamed(context, RoutesCatalog.homeScreen, arguments: index);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // call _player.stop()
    if (state == AppLifecycleState.detached) {
      context.read<AudioManagementCubit>().stopAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Appbar(onPress: onSelect),
      ),
      body: BlocProvider.value(
        value: BlocProvider.of<AudioManagementCubit>(context),
        child: Container(
          child: Globals.navBarPageList[_page],
        ),
      ),
      bottomNavigationBar: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: BlocProvider.of<AudioManagementCubit>(context),
          ),
          BlocProvider.value(
           value: BlocProvider.of<MiniPlayerManagementCubit>(context),
          ),
        ],
        child: BottomNavBar(selected: _page, onSelect: onSelect),
      ),
    );
  }
}
