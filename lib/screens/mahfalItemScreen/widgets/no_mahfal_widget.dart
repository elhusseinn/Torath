import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/core/utils/assets_catalog.dart';

class NoMahfalWidget extends StatelessWidget {
  const NoMahfalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 85.h),
      padding: EdgeInsets.symmetric(vertical: 24.h),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(39.r),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x3F000000),
            blurRadius: 4.r,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(top: 20.h),
              child: SvgPicture.asset(AssetsCatalog.notFound)),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Text(
                  'عذرًا، لا يوجد تلاوات تحتوي على هذه السورة في الوقت الحالي.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontFamily: 'IBM Plex Sans',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 45.h),
                  child: SvgPicture.asset(
                    AssetsCatalog.backButton,
                    height: 80.h,
                    width: 80.w,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
