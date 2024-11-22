import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/routes_catalog.dart';

import '../../core/utils/assets_catalog.dart';
import 'memorial_text.dart';

class AnimatedSecondScreen extends StatefulWidget {
  const AnimatedSecondScreen({Key? key}) : super(key: key);

  @override
  _AnimatedSecondScreenState createState() => _AnimatedSecondScreenState();
}

class _AnimatedSecondScreenState extends State<AnimatedSecondScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer for navigation
    Timer(Duration(milliseconds: 5500), _navigateToNextScreen);
  }

  void _navigateToNextScreen() {
    // Ensure the widget is still mounted before navigating
    if (!mounted) return;

    bool? isNewUser = PreferenceManager.isNewUser();
    if (isNewUser == true || isNewUser == null) {
      Navigator.of(context).pushReplacementNamed(RoutesCatalog.onBoarding);
    } else {
      Navigator.of(context).pushReplacementNamed(RoutesCatalog.homeScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color(0xFFD0D9D0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Image.asset(AssetsCatalog.landingSplash),
            )
                .animate()
                .slideY(
              duration: Duration(milliseconds: 1500),
              delay: Duration(milliseconds: 1000),
              end: -0.4,
              begin: 0.5,
              curve: Curves.easeIn,
            ),
            MemorialText(),
          ],
        ),
      ),
    );
  }
}
