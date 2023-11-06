// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/commonWidgets/text_rtl.dart';

import '../../core/images.dart';
import 'memorial_text.dart';

class AnimatedSecondScreen extends StatelessWidget {
  const AnimatedSecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 5500),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Container())));
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFD0D9D0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(Images.landingSplash),
              ).animate().slideY(
                  duration: Duration(milliseconds: 1500),
                  delay: Duration(milliseconds: 1000),
                  end: -0.4,
                  begin: 0.5),
              MemorialText(),
            ],
          )),
    );
  }


}
