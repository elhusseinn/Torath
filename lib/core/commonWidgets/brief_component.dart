import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/commonWidgets/text_rtl.dart';
import 'package:torath/core/utils/colors_catalog.dart';

class BriefComponent extends StatelessWidget {
  String image;
  String text;
  BriefComponent({required this.text, required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: ColorsCatalog.backGroundColor,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 30.w, top: 10.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Image.asset(image)],
            ),
          ),
          SizedBox(height: 10.h,),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RtlText(
                  content: text,
                  style: TextStyle(
                    color: const Color(0xFF2D2B2B),
                    fontSize: 20.sp,
                    fontFamily: 'IBM Plex Sans',
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
