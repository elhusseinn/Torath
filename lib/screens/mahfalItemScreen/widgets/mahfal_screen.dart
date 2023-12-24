import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:torath/screens/mahfalItemScreen/widgets/mahfal_media_item.dart';

import '../../../core/utils/assets_catalog.dart';
import '../../../models/getMahfal/mahfal_data.dart';
import 'filter_bottom_sheet.dart';

class MahfalScreen extends StatefulWidget {
  List<MahfalData> data;
  Set<String> filterPlaces;
  Set<String> filterTimes;
  MahfalScreen(
      {super.key,
      required this.data,
      required this.filterPlaces,
      required this.filterTimes});

  @override
  State<MahfalScreen> createState() => _MahfalScreenState();
}

class _MahfalScreenState extends State<MahfalScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: SvgPicture.asset(AssetsCatalog.backButton),
              ),
              GestureDetector(
                onTap: () {
                  _showFilterBottomSheet(context);
                },
                child: SvgPicture.asset(AssetsCatalog.filterButton),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.h),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.data.length,
              itemBuilder: (context, index) {
                return MahfalMediaItem(mahfalData: widget.data[index]);
              },
            ),
          ),
        )
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: (context) => FilterBottomSheet(
              filterTimes: widget.filterTimes,
              filterPlaces: widget.filterPlaces,
            ));
  }
}
