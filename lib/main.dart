import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/firebase_options.dart';
import 'package:total_cricinfo/routes/app_routes.dart';
import 'package:total_cricinfo/routes/route_names.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure edge-to-edge layout compatibility
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  // Optionally, make system bars transparent
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      systemNavigationBarColor: Colors.transparent, // Transparent bottom bar
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Total CricInfo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: false,
        appBarTheme: AppBarTheme(backgroundColor: primaryColor),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
          ),
        ),
        scaffoldBackgroundColor: backgreoundColor,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Lato'),
          displayMedium: TextStyle(fontFamily: 'Lato'),
          displaySmall: TextStyle(fontFamily: 'Lato'),
          headlineLarge: TextStyle(fontFamily: 'Lato'),
          headlineMedium: TextStyle(fontFamily: 'Lato'),
          headlineSmall: TextStyle(fontFamily: 'Lato'),
          labelLarge: TextStyle(fontFamily: 'Lato'),
          labelMedium: TextStyle(fontFamily: 'Lato'),
          labelSmall: TextStyle(fontFamily: 'Lato'),
          bodyLarge: TextStyle(fontFamily: 'Lato'),
          bodyMedium: TextStyle(fontFamily: 'Lato'),
          bodySmall: TextStyle(fontFamily: 'Lato'),
          titleLarge: TextStyle(fontFamily: 'Lato'),
          titleMedium: TextStyle(fontFamily: 'Lato'),
          titleSmall: TextStyle(fontFamily: 'Lato'),
        ),
      ),
      getPages: AppRoutes.appRoutes(),
      initialRoute: RouteNames.homeScreen,
    );
  }
}
