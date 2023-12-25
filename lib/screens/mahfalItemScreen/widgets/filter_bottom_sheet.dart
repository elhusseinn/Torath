// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_button/group_button.dart';

import '../../../core/utils/assets_catalog.dart';

class FilterBottomSheet extends StatefulWidget {
  List<String> filterPlaces;
  List<String> filterTimes;
  Function filter;
  FilterBottomSheet(
      {super.key,
      required this.filterTimes,
      required this.filterPlaces,
      required this.filter});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final timesController = GroupButtonController();
  final placesController = GroupButtonController();
  List<String> selectedTimes = [];
  List<String> selectedPlaces = [];

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

          //body
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 15.w),
            margin: EdgeInsets.only(top: 15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  color: Colors.transparent,
                  height: MediaQuery.of(context).size.height * 0.189,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // times Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: GestureDetector(
                              onTap: () {
                                timesController.unselectAll();
                              },
                              child: Icon(
                                Icons.refresh_rounded,
                                size: 27.h,
                              ),
                            ),
                          ),
                          Text(
                            'الزمان',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontFamily: 'Dubai',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Expanded(
                        child: _buildGroupButton(
                            items: widget.filterTimes,
                            controller: timesController),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.189,
                  margin: EdgeInsets.only(top: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 15.w),
                            child: GestureDetector(
                              onTap: () {
                                placesController.unselectAll();
                              },
                              child: Icon(
                                Icons.refresh_rounded,
                                size: 27.h,
                              ),
                            ),
                          ),
                          Text(
                            'المكان',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontFamily: 'Dubai',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: _buildGroupButton(
                            items: widget.filterPlaces,
                            controller: placesController),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          // submit button
          GestureDetector(
            onTap: () {
              selectedTimes = [];
              selectedPlaces = [];
              for (int index in timesController.selectedIndexes) {
                selectedTimes.add(widget.filterTimes.toList()[index]);
              }
              for (int index in placesController.selectedIndexes) {
                selectedPlaces.add(widget.filterPlaces.toList()[index]);
              }
              widget.filter(selectedPlaces.isEmpty ? null : selectedPlaces,
                  selectedTimes.isEmpty ? null : selectedTimes);

              Navigator.of(context).pop();
            },
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(right: 20.w, left: 20.w, top: 10.h),
              height: 40.h,
              color: Color(0xFF4A6848),
              child: Center(
                child: Text(
                  'بدأ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontFamily: 'IBM Plex Sans',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildGroupButton(
      {required List<String> items,
      required GroupButtonController controller}) {
    return SingleChildScrollView(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(right: 10.w, top: 10.h),
            width: double.infinity,
            child: GroupButton(
              controller: controller,
              options: GroupButtonOptions(
                mainGroupAlignment: MainGroupAlignment.start,
                spacing: 5.w,
                textPadding: EdgeInsets.symmetric(horizontal: 35.w),
                groupingType: GroupingType.wrap,
                textAlign: TextAlign.center,
                unselectedColor: Color(0xFFD9D9D9),
                unselectedBorderColor: Color(0xFFE9EDF0),
                selectedColor: Color(0xFF4A6848),
                selectedBorderColor: Color(0xFF4A6848),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                selectedTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontFamily: 'Dubai',
                  fontWeight: FontWeight.w400,
                ),
                unselectedTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontFamily: 'Dubai',
                  fontWeight: FontWeight.w400,
                ),
                buttonHeight: 34.h,
                // buttonWidth: 100.w
              ),
              isRadio: false,
              buttons: items.toList(),
            ),
          )),
    );
  }
}
