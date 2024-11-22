import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/routes_catalog.dart';

import '../homeScreen/app_bar.dart';
import '../homeScreen/bottom_navigation_bar.dart';

class PageTemplate extends StatefulWidget {
  Widget page;

  PageTemplate({required this.page, super.key});

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  void onSelect(index) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(
        context, RoutesCatalog.homeScreen, arguments: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Appbar(onPress: onSelect),
      ),
      body: Container(
        color: const Color(0xFFD0D9D0),
        child: widget.page,
      ),
      bottomNavigationBar: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: PreferenceManager().audioManagementCubit,
          ),
          BlocProvider.value(
            value: PreferenceManager().miniPlayerManagementCubit,
          ),
        ],
        child: BottomNavBar(selected: -1, onSelect: onSelect),
      ),

    );
  }
}
