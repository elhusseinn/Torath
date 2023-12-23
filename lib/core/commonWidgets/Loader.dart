import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:torath/core/commonWidgets/pageTemplate/page_template.dart';
class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return PageTemplate(page: Scaffold(
    body: Center(
    child: LoadingAnimationWidget.hexagonDots(
    color: Colors.black,
    size: 50.sp,
    ),
    ),));
  }
}
