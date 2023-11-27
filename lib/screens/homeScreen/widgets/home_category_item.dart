import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/core/commonWidgets/text_rtl.dart';
import 'package:torath/core/language/text.dart';
import 'package:torath/core/utils/assets_catalog.dart';

class HomeCategoryItem extends StatelessWidget {
  String? title;
  String? icon;
  String routeName;
  HomeCategoryItem(
      {required this.title, required this.icon,required this.routeName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          Center(
            child: RtlText(
              content: title!,
              style: TextStyle(
                color: const Color(0xFF4F4C4C),
                fontSize: 25.sp,
                fontFamily: 'IBM Plex Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.only(right: 10.w),
            child: SvgPicture.asset(
              icon!,
            ),
          ),
          // Icon(icon)
        ],
      ),
    );
  }
}
