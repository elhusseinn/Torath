import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/commonWidgets/text_rtl.dart';
class MemorialText extends StatelessWidget {
  const MemorialText({super.key});

  @override
  Widget build(BuildContext context) {
     return Center(
      child: Container(
        // padding: EdgeInsets.only(top: 50.h),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RtlText(
                content: 'في ذكري شيخنا',
                style: TextStyle(
                  color: const Color(0xFF2D2B2B),
                  fontSize: 40.0.sp,
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              RtlText(
                content: ' و محبوبنا',
                style: TextStyle(
                  color: const Color(0xFF2D2B2B),
                  fontSize: 40.0.sp,
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              RtlText(
                content: 'مصطفي إسماعيل',
                style: TextStyle(
                  color: const Color(0xFF2D2B2B),
                  fontSize: 40.0.sp,
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              RtlText(
                content: 'رحمة الله عليه',
                style: TextStyle(
                  color: const Color(0xFF2D2B2B),
                  fontSize: 40.0.sp,
                  fontFamily: 'IBMPlexSans',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ]).animate().fadeIn(
            duration: const Duration(milliseconds: 2000),
            delay: const Duration(milliseconds: 3000)),
      ),
    );
  }
}
