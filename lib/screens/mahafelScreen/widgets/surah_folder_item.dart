import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/core/commonWidgets/text_rtl.dart';
import 'package:torath/core/utils/assets_catalog.dart';
import 'package:torath/core/utils/routes_catalog.dart';

class SurahFolderItem extends StatelessWidget {
  String surahName;
  SurahFolderItem({required this.surahName, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, RoutesCatalog.mahfalScreen, arguments: surahName);
      },
      child: Container(
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
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
        // height: 110.h,
        // width: 110.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AssetsCatalog.folderIcon),
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
      ),
    );
  }
}
