import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterItem extends StatefulWidget {
  String item;
  FilterItem({super.key, required this.item});

  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFE9EDF0),
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.w, color: const Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
      child: Text(
        widget.item,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.sp,
          fontFamily: 'Dubai',
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
