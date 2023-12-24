import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/utils/assets_catalog.dart';
class FilterBottomSheet extends StatefulWidget {
  Set<String> filterPlaces;
  Set<String> filterTimes;
   FilterBottomSheet({super.key , required this.filterTimes, required this.filterPlaces});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: ShapeDecoration(
        color: const Color(0xFFF3F5FE),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
        ),
      ),
      child: Column(
        children: [
          //row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(color: Colors.red,width: 54.w,),
              Text(
                'فلتر ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23.sp,
                  fontFamily: 'IBM Plex Sans',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SvgPicture.asset(AssetsCatalog.filterExit),

            ],

          ),
        ],
      ),

    );
  }
}
