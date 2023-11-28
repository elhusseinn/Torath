import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/core/commonWidgets/text_rtl.dart';
import 'package:torath/core/utils/assets_catalog.dart';

class SurahFolderItem extends StatelessWidget {
  String surahName;
  SurahFolderItem({required this.surahName, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
      height: 110.h,
      width: 110.w,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20.h, left: 15.w, right: 15.w),
            child: SvgPicture.asset(AssetsCatalog.folderIcon),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          RtlText(
            content: "سورة $surahName",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontFamily: 'Amiri',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
