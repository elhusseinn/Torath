import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:torath/core/utils/preference_manager.dart';
import 'package:torath/core/utils/routes.dart';
import 'package:torath/screens/splashScreens/animated_first_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);

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
            onGenerateRoute:
                AppRouter(preferenceManager: PreferenceManager()).generateRoute,
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
