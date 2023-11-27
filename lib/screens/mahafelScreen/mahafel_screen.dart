// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/commonWidgets/pageTemplate/page_template.dart';
import 'package:torath/screens/mahafelScreen/widgets/surah_folder_item.dart';

import '../../core/utils/globals.dart';

class MahfelScreen extends StatefulWidget {
  const MahfelScreen({super.key});

  @override
  State<MahfelScreen> createState() => _MahfelScreenState();
}

class _MahfelScreenState extends State<MahfelScreen> {
  List<String> _quranSorahNames = Globals.quranSorahNames;
  List<String> _searchResult = [];

  void _search(String query) {
    if (query.isEmpty) {
      _quranSorahNames = Globals.quranSorahNames;
    } else {
      _searchResult = [];
      for (String element in Globals.quranSorahNames) {
        if (element.contains(query)) {
          _searchResult.add(element);
        }
      }
      setState(() {
        _quranSorahNames = _searchResult;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      page: Container(
        padding: EdgeInsets.only(top: 15.h),
        child: Column(
          children: [
            _searchBar(),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: _surahGrid()),
            ),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Container(
        height: 71.h,
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.8509804010391235),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
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
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Center(
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.sp,
                fontFamily: 'IBM Plex Sans',
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.search_rounded,
                  size: 30.h,
                ),
                hintText: "...بحث",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.41999998688697815),
                  fontSize: 25.sp,
                  fontFamily: 'IBM Plex Sans',
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
              enableSuggestions: false,
              autocorrect: false,
              textAlign: TextAlign.end,
              maxLines: 1,
              showCursor: false,
              onChanged: (input) {
                _search(input);
              },
              onSubmitted: (searchInput) {
                _search(searchInput);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _surahGrid() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.h,
          ),
          itemCount: _quranSorahNames.length,
          itemBuilder: (context, index) {
            return SurahFolderItem(surahName: _quranSorahNames[index]);
          }),
    );
  }
}
