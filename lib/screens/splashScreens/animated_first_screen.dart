import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'animated_second_screen.dart';
class AnimatedFirstScreen extends StatelessWidget {
   AnimatedFirstScreen({super.key}){

  }


  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/appIcon_big.png',
      nextScreen:   AnimatedSecondScreen(),
      backgroundColor: const Color(0xFFD0D9D0),
      splashIconSize: double.infinity,
    );
  }
}
