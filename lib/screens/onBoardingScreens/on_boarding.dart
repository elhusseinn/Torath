import 'package:flutter/material.dart';
import 'package:torath/core/commonWidgets/brief_component.dart';
import 'package:torath/core/language/text.dart';
import 'package:torath/core/utils/colors_catalog.dart';

import '../../core/utils/images.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsCatalog.backGroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BriefComponent(text: ArabicText.brief1, image: Images.brief1)
          ],
        ),
      ),
    );
  }
}
