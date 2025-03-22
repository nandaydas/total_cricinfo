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

  final List pages = [
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
        body: Obx(
          () => pages[hc.selectedIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 64,
            backgroundColor: Colors.white,
            selectedIndex: hc.selectedIndex.value,
            onDestinationSelected: (value) {
              hc.selectedIndex.value = value;
            },
            destinations: [
              NavigationDestination(
                selectedIcon: Icon(
                  Iconsax.home,
                  color: primaryColor,
                ),
                icon: const Icon(Iconsax.home_copy),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.sports_cricket_rounded,
                  color: primaryColor,
                ),
                icon: const Icon(Icons.sports_cricket_outlined),
                label: 'Matches',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.emoji_events_rounded,
                  color: primaryColor,
                ),
                icon: const Icon(Icons.emoji_events_outlined),
                label: 'Series',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.newspaper_rounded,
                  color: primaryColor,
                ),
                icon: const Icon(Icons.newspaper_outlined),
                label: 'News',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
