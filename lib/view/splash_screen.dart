import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/view/home/home_page.dart';
import '../controllers/match_list_controller.dart';
import '../controllers/news_controller.dart';
import '../controllers/series_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  final MatchListController mlc = Get.put(MatchListController());
  final NewsController nc = Get.put(NewsController());
  final SeriesController sc = Get.put(SeriesController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      },
    );
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'SixCric',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato',
                color: Colors.white,
              ),
            ),
            Text(
              'Blizzing Cricket Updates',
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
            )
          ],
        ),
      ),
    );
  }
}
