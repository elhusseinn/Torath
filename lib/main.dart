import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/properties.dart';
import 'package:torath/core/utils/routes.dart';
import 'package:torath/screens/splashScreens/animated_first_screen.dart';

import 'core/network/network_info.dart';
import 'core/repository/repo_implementation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Properties properties = Properties();
  PreferenceManager preferenceManager = PreferenceManager();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF4F6FF),
      child: ScreenUtilInit(
        designSize: const Size(414, 842),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
            // localizationsDelegates: const [
            //   GlobalCupertinoLocalizations.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            // ],
            // supportedLocales: const [
            //   Locale("ar"),
            // ],
            // locale: const Locale("ar"),
            onGenerateRoute: AppRouter(
              preferenceManager: PreferenceManager(),
              repo: Repository(NetworkInfo(con: DataConnectionChecker())),
            ).generateRoute,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            title: 'Torath',
            theme: ThemeData(
              fontFamily: "IBM Plex Sans",
              primarySwatch: Colors.green,
            ),
            home: AnimatedFirstScreen()
            // Container()
            ),
      ),
    );
  }
}
