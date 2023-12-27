import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:torath/core/commonWidgets/brief_component.dart';
import 'package:torath/core/commonWidgets/text_rtl.dart';
import 'package:torath/core/language/text.dart';
import 'package:torath/core/utils/colors_catalog.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/routes_catalog.dart';

import '../../core/utils/assets_catalog.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  int currentIndexPage = 0;
  List<BriefComponent> pages = [
    BriefComponent(text: ArabicText.brief1, image: AssetsCatalog.brief1),
    BriefComponent(text: ArabicText.brief2, image: AssetsCatalog.brief2),
    BriefComponent(text: ArabicText.brief3, image: AssetsCatalog.brief3),
    BriefComponent(text: ArabicText.brief4, image: AssetsCatalog.brief4),
    BriefComponent(text: ArabicText.brief5, image: AssetsCatalog.brief5),
    BriefComponent(text: ArabicText.brief6, image: AssetsCatalog.brief6),
    BriefComponent(text: ArabicText.brief7)
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: ColorsCatalog.backGroundColor,
        // color: Colors.blueGrey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, RoutesCatalog.homeScreen);
                // invalidates NewUser
                PreferenceManager.setNewUser(false);
                print(PreferenceManager.isNewUser);
              },
              child: Container(
                // skip button
                // color: Colors.black,
                padding: EdgeInsets.only(right: 10.w, top: 50.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RtlText(
                      content: ArabicText.skip,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'IBM Plex Sans',
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    SvgPicture.asset(AssetsCatalog.nextArrow),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 700.h,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentIndexPage = value;
                  });
                },
                controller: _pageController,
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: pages
                    .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [e],
                        ))
                    .toList(),
              ),
            ).animate().slideX(
                begin: 0.5,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn),
            // SizedBox(height: 10.h,),
            Container(
              // color: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //previous button
                  currentIndexPage != 0
                      ? GestureDetector(
                          onTap: () {
                            _pageController.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut);
                          },
                          child: SvgPicture.asset(AssetsCatalog.previousArrow),
                        )
                      : Container(),

                  //dots indicator
                  DotsIndicator(
                    position: currentIndexPage.toDouble(),
                    decorator: DotsDecorator(
                      spacing: EdgeInsets.only(left: 10.w),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      activeColor: const Color(0xFF71AAAA),
                      activeSize: const Size(10, 10),
                    ),
                    dotsCount: pages.length,
                  ),

                  //next button
                  GestureDetector(
                    onTap: () {
                      if (currentIndexPage == pages.length - 1) {
                        Navigator.pushReplacementNamed(
                            context, RoutesCatalog.homeScreen);
                        // invalidates NewUser
                        PreferenceManager.setNewUser(false);
                        print(PreferenceManager.isNewUser());
                      } else {
                        print(PreferenceManager.isNewUser());
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.easeIn);
                      }
                    },
                    child: SvgPicture.asset(AssetsCatalog.nextArrow),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
