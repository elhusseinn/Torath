import 'package:flutter/material.dart';
import 'package:torath/core/commonWidgets/brief_component.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/routes_catalog.dart';
import 'package:torath/screens/onBoardingScreens/on_boarding.dart';

import 'images.dart';

class AppRouter{
  PreferenceManager preferenceManager;
  AppRouter({required this.preferenceManager});

  Route? generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesCatalog.onBoarding:
        return MaterialPageRoute(
            builder: (_) => OnBoarding()
        );
    }

    return null;
  }
}