// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/routes_catalog.dart';

import '../../core/utils/assets_catalog.dart';
import 'memorial_text.dart';

class AnimatedSecondScreen extends StatelessWidget {
   AnimatedSecondScreen({super.key});
  bool? isNewUser=true;

  @override
  Widget build(BuildContext context){
    Timer(
        Duration(milliseconds: 5500),
        () {
        isNewUser= PreferenceManager.isNewUser();
          if(isNewUser == true|| isNewUser == null){
            Navigator.of(context).pushReplacementNamed(RoutesCatalog.onBoarding);
          }
          else{
            Navigator.of(context).pushReplacementNamed(RoutesCatalog.homeScreen);
          }
        }
    );
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
              ).animate().slideY(
                  duration: Duration(milliseconds: 1500),
                  delay: Duration(milliseconds: 1000),
                  end: -0.4,
                  begin: 0.5,
              curve:Curves.easeIn),
              MemorialText(),
            ],
          )),
    );
  }


}
