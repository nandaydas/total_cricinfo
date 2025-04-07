import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/match_list_controller.dart';
import 'package:total_cricinfo/controllers/series_controller.dart';
import 'package:total_cricinfo/view/series/series_matches_tab.dart';
import 'package:total_cricinfo/view/series/series_news_tab.dart';
import 'package:total_cricinfo/view/series/series_table_tab.dart';
import '../../controllers/ad_controller.dart';

class SeriesViewPage extends StatelessWidget {
  SeriesViewPage({
    super.key,
  });

  final Map seriesData = Get.arguments;
  final MatchListController mlc = Get.put(MatchListController());
  final SeriesController sc = Get.put(SeriesController());
  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    sc.getSeriesUpcomingList(seriesData['series_id']);
    mlc.getSeriesResultList(seriesData['series_id']);
    sc.getData(seriesData);
    log(seriesData['series_id'].toString());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('${seriesData['series']}'),
          bottom: TabBar(
            indicatorColor: accentColor,
            tabs: const [
              Tab(
                text: 'Matches',
              ),
              Tab(
                text: 'Points Table',
              ),
              Tab(
                text: 'News',
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
          final banner = adController.bannerAd.value;
          if (banner != null) {
            return SizedBox(
              height: banner.size.height.toDouble(),
              width: double.infinity,
              child: AdWidget(ad: banner),
            );
          } else {
            return const SizedBox();
          }
        }),
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: TabBarView(
              children: [
                SeriesMatchesTab(
                  seriesId: seriesData['series_id'],
                ),
                SeriesTableTab(),
                SeriesNewsTab()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
