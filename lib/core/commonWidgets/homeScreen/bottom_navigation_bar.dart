import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:torath/core/language/text.dart';
import 'package:torath/core/utils/assets_catalog.dart';

class BottomNavBar extends StatefulWidget {
  int? selected;
  Function onSelect;
  BottomNavBar({this.selected, required this.onSelect, super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
      child: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      selectedItemColor: const Color(0xFF224520),
      unselectedItemColor: const Color(0xFFD9D9D9),
      selectedFontSize: 13.0,
      unselectedFontSize: 13.0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsCatalog.navBarHomeIcon,
                width: 25,
                height: 25,
                color: widget.selected == 0
                    ? const Color(0xFF224520)
                    : const Color(0xFFD9D9D9)),
            label: ArabicText.mainHome),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsCatalog.favIcon,
                width: 25,
                height: 25,
                color: widget.selected == 1
                    ? const Color(0xFF224520)
                    : const Color(0xFFD9D9D9)),
            label: ArabicText.favourite),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsCatalog.seraIcon,
                width: 25,
                height: 25,
                color: widget.selected == 2
                    ? const Color(0xFF224520)
                    : const Color(0xFFD9D9D9)),
            label: ArabicText.sera),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(AssetsCatalog.contactUsIcon,
                width: 25,
                height: 25,
                color: widget.selected == 3
                    ? const Color(0xFF224520)
                    : const Color(0xFFD9D9D9)),
            label: ArabicText.contactUs),
      ],
      // currentIndex: widget.selected!,
      onTap: (index) {
        widget.onSelect(index);
      },
      backgroundColor: const Color(0xFF4A6848),
    );
  }

  // NavigationBar buildNavigationBar() {
  //   return NavigationBar(
  //     selectedIndex: 0,
  //     indicatorColor: Colors.transparent,
  //     labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
  //     // elevation: 10,
  //     // height: 30.h,
  //     // backgroundColor: Colors.transparent,
  //     backgroundColor: const Color(0xFF4A6848),
  //     destinations: [
  //       NavigationDestination(
  //           icon: SvgPicture.asset(AssetsCatalog.favIcon,
  //               height: 25,
  //               width: 25,
  //               color: widget.selected == 0
  //                   ? const Color(0xFF224520)
  //                   : const Color(0xFFD9D9D9)),
  //           label: ArabicText.favourite),
  //       NavigationDestination(
  //           icon: SvgPicture.asset(AssetsCatalog.seraIcon,
  //               height: 25,
  //               width: 25,
  //               color: widget.selected == 1
  //                   ? const Color(0xFF224520)
  //                   : const Color(0xFFD9D9D9)),
  //           label: ArabicText.sera),
  //       NavigationDestination(
  //           icon: SvgPicture.asset(AssetsCatalog.contactUsIcon,
  //               color: widget.selected == 2
  //                   ? const Color(0xFF224520)
  //                   : const Color(0xFFD9D9D9)),
  //           label: ArabicText.contactUs)
  //     ],
  //     onDestinationSelected: (index) {
  //       setState(() {
  //         widget.onSelect(index);
  //       });
  //     },
  //   );
  // }
}
