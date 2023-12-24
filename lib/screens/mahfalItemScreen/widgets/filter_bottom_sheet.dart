import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/screens/mahfalItemScreen/widgets/filter_item.dart';

import '../../../core/utils/assets_catalog.dart';

class FilterBottomSheet extends StatefulWidget {
  Set<String> filterPlaces;
  Set<String> filterTimes;
  FilterBottomSheet(
      {super.key, required this.filterTimes, required this.filterPlaces});

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
              Container(
                color: Colors.red,
                width: 54.w,
              ),
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(AssetsCatalog.filterExit),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height*0.189,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            margin: EdgeInsets.only(top: 21.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'الزمان',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontFamily: 'Dubai',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: _buildGrid(items: widget.filterTimes),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid({required Set<String> items}) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 6,
            crossAxisCount: 3,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.h,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Center(
              child: FilterItem(item: items.toList()[index]),
            );
          }),
    );
  }
}
