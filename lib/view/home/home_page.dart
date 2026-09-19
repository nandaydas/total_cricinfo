import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/home_controller.dart';
import 'package:total_cricinfo/view/home/front_page.dart';
import 'package:total_cricinfo/view/home/matches_page.dart';
import 'package:total_cricinfo/view/home/news_page.dart';
import 'package:total_cricinfo/view/home/series_page.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Widget> pages = [
    FrontPage(),
    MatchesPage(),
    SeriesPage(),
    NewsPage(),
  ];

  final HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      dialogStyle: defaultTargetPlatform == TargetPlatform.android
          ? UpgradeDialogStyle.material
          : UpgradeDialogStyle.cupertino,
      showIgnore: false,
      showLater: false,
      child: Scaffold(
        extendBody: true,
        body: SafeArea(
          child: Obx(
            () => AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: child,
              ),
              child: pages[hc.selectedIndex.value],
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: NavigationBar(
              height: 64,
              backgroundColor: Colors.transparent,
              elevation: 0,
              indicatorColor: primaryColor.withOpacity(0.1),
              selectedIndex: hc.selectedIndex.value,
              onDestinationSelected: (value) {
                hc.selectedIndex.value = value;
              },
              destinations: const [
                NavigationDestination(
                  selectedIcon: Icon(Iconsax.home, color: Colors.black),
                  icon: Icon(Iconsax.home_copy),
                  label: 'Home',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.sports_cricket_rounded, color: Colors.black),
                  icon: Icon(Icons.sports_cricket_outlined),
                  label: 'Matches',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.emoji_events_rounded, color: Colors.black),
                  icon: Icon(Icons.emoji_events_outlined),
                  label: 'Series',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.newspaper_rounded, color: Colors.black),
                  icon: Icon(Icons.newspaper_outlined),
                  label: 'News',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}