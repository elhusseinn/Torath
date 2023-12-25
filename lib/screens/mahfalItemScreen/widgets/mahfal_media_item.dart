import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/getMahfal/mahfal_data.dart';
import '../../../core/utils/assets_catalog.dart';

class MahfalMediaItem extends StatelessWidget {
  MahfalData mahfalData;
  MahfalMediaItem({super.key, required this.mahfalData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      // padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
      padding:
          EdgeInsets.only(top: 18.h, left: 14.w, right: 14.w, bottom: 10.h),
      decoration: ShapeDecoration(
        color: Colors.white.withOpacity(0.8509804010391235),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(AssetsCatalog.musicIcon),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "سورة ${mahfalData.surah!}",
                  style: TextStyle(
                    color: const Color(0xFF4F4C4C),
                    fontSize: 32.sp,
                    fontFamily: 'IBM Plex Sans',
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: MediaQuery.of(context).size.width*0.45,
                    padding: EdgeInsets.only(right: 20.w),
                    child: Text(
                      "${mahfalData.place!} - ${mahfalData.timeYear!}",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                        fontFamily: 'IBM Plex Sans',
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.clip
                      ),


                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(children: [
            Image.asset(
              AssetsCatalog.mediaItemPic,
              height: 44.h,
              width: 44.w,
            ),
            SizedBox(
              height: 15.h,
            ),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                AssetsCatalog.playIcon,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
