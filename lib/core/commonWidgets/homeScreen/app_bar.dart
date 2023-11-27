import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/core/commonWidgets/text_rtl.dart';
import 'package:torath/core/language/text.dart';

import '../../utils/assets_catalog.dart';

class Appbar extends StatelessWidget {
  Function onPress;
   Appbar({required this.onPress ,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD0D9D0),
      child: AppBar(
        backgroundColor: const Color(0xFF4A6848),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
        ),
        elevation: 6,
        leadingWidth: 100.w,
        leading: Container(
          padding: EdgeInsets.only(left: 10.w),
          child: GestureDetector(
            onTap: () {
              onPress(0);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: SvgPicture.asset(
              AssetsCatalog.homeIcon,
            ),
          ),
        ),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20.w),
            child: RtlText(
              content: ArabicText.torath,
              style: TextStyle(
                color: const Color(0xFFD9D9D9),
                fontSize: 36.sp,
                fontFamily: 'Amiri',
                fontWeight: FontWeight.w400,
                // shadows: const [
                //   BoxShadow(
                //     color: Color(0x3F000000),
                //     blurRadius: 4,
                //     offset: Offset(0, 4),
                //     spreadRadius: 0,
                //   )
                // ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
