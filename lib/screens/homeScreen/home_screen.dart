import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/language/text.dart';
import 'package:torath/core/utils/assets_catalog.dart';
import 'package:torath/core/utils/routes_catalog.dart';
import 'package:torath/screens/homeScreen/widgets/home_category_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<HomeCategoryItem> items = [
    HomeCategoryItem(
      title: ArabicText.mogawad,
      icon: AssetsCatalog.mogawad,
      routeName: RoutesCatalog.sowarScreen,
    ),
    HomeCategoryItem(
      title: ArabicText.moratal,
      icon: AssetsCatalog.moratal,
      routeName: RoutesCatalog.sowarScreen,
    ),
    HomeCategoryItem(
      title: ArabicText.mahafel,
      icon: AssetsCatalog.mahafel,
      routeName: RoutesCatalog.sowarScreen,
    ),
    HomeCategoryItem(
      title: ArabicText.azan,
      icon: AssetsCatalog.azan,
      routeName: RoutesCatalog.sowarScreen,
    ),
    HomeCategoryItem(
      title: ArabicText.pictures,
      icon: AssetsCatalog.pictures,
      routeName: RoutesCatalog.sowarScreen,
    ),
    HomeCategoryItem(
      title: ArabicText.tvMeetings,
      icon: AssetsCatalog.tvMeetings,
      routeName: RoutesCatalog.sowarScreen,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD0D9D0),
      child: Container(
        padding: EdgeInsets.only(top: 70.h),
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, items[index].routeName);
                },
                child: Container(
                  padding: EdgeInsets.only(bottom: 15.h, right: 5.h, left: 5.h),
                  child: items[index],
                ),
              );
            }),
      ),
    );
  }
}
