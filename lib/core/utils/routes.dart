// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:torath/core/commonWidgets/brief_component.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/routes_catalog.dart';
import 'package:torath/cubits/filterCubits/getAllPlacesTimesCubit/get_all_places_times_cubit.dart';
import 'package:torath/cubits/getMahfalCubit/get_mahfal_cubit.dart';
import 'package:torath/models/DAOs/audio_player_dao.dart';
import 'package:torath/screens/audioPlayer/audio_player.dart';
import 'package:torath/screens/homeScreen/home_tabs.dart';
import 'package:torath/screens/mahfalItemScreen/mahafel_item_screen.dart';
import 'package:torath/screens/onBoardingScreens/on_boarding.dart';

import '../../screens/mahafelScreen/mahafel_screen.dart';
import '../repository/repo_interface.dart';
import 'assets_catalog.dart';

class AppRouter {
  IRepository repo;
  PreferenceManager preferenceManager;

  AppRouter({required this.preferenceManager, required this.repo});

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesCatalog.onBoarding:
        return MaterialPageRoute(builder: (_) => OnBoarding());

      case RoutesCatalog.homeScreen:
        final args = settings.arguments as int?;
        return MaterialPageRoute(
            builder: (_) => HomeTabs(
                  selectedPage: args,
                ));

      case RoutesCatalog.audioPlayer:
        final args = settings.arguments as AudioPlayerDao;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              AudioPlayerScreen(audio: args),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Define the offset animation (from bottom to top)
            const begin = Offset(0.0, 1.0);
            const end = Offset(0.0, 0.0);
            const curve = Curves.easeInOut;

            final tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            final offsetAnimation = animation.drive(tween);

            // Apply the offset animation to the child widget
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        );

      case RoutesCatalog.sowarScreen:
        return MaterialPageRoute(builder: (_) => SowarScreen());

      case RoutesCatalog.mahfalScreen:
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => GetMahfalCubit(repo),
                    ),
                    BlocProvider(
                      create: (context) =>
                          GetAllPlacesCubit(repo)..getPlacesTimes(args),
                    ),
                  ],
                  child: MahfalItemScreen(
                    surahName: args,
                  ),
                ));
    }
    return null;
  }
}
