import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/live_controller.dart';
import 'package:total_cricinfo/controllers/match_info_controller.dart';
import 'package:total_cricinfo/view/match/commentary_tab.dart';
import 'package:total_cricinfo/view/match/expert_picks_tab.dart';
import 'package:total_cricinfo/view/match/info_tab.dart';
import 'package:total_cricinfo/view/match/live_tab.dart';
import 'package:total_cricinfo/view/match/scorecard_tab.dart';
import 'package:total_cricinfo/view/match/squads_tab.dart';
import '../../controllers/ad_controller.dart';

class MatchViewPage extends StatelessWidget {
  MatchViewPage({
    super.key,
  });

  final Map matchData = Get.arguments;
  final LiveController lc = Get.put(LiveController());
  final MatchInfoController mic = Get.put(MatchInfoController());
  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration.zero,
      () {
        adController.loadBannerAd();

        mic.getData(matchData['match_id']);
        lc.getData(matchData);
      },
    );
    return DefaultTabController(
      length: 6,
      initialIndex: matchData['match_status'] == 'Upcoming' ? 0 : 1,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              "${matchData['team_a_short'] ?? '-'} vs ${matchData['team_b_short'] ?? '-'}, ${matchData['matchs']}"),
          bottom: TabBar(
            indicatorColor: accentColor,
            isScrollable: true,
            tabs: const [
              Tab(
                text: ' Info ',
              ),
              Tab(
                text: ' Live ',
              ),
              Tab(
                text: 'Expert Picks',
              ),
              Tab(
                text: 'Commentary',
              ),
              Tab(
                text: 'Scorecard',
              ),
              Tab(
                text: ' Squads ',
              ),
            ],
          ),
          actions: [
            Visibility(
              visible: matchData['match_status'] == 'Upcoming',
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active_outlined),
              ),
            )
          ],
        ),
        bottomNavigationBar: Obx(
          () {
            final banner = adController.bannerAd.value;
            if (banner != null) {
              return SizedBox(
                height: banner.size.height.toDouble(),
                width: banner.size.width.toDouble(),
                child: AdWidget(ad: banner),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        body: GetBuilder<LiveController>(
          initState: (_) {
            if (matchData['match_status'] != 'Finished') {
              Timer.periodic(
                matchData['match_status'] == 'Live'
                    ? const Duration(seconds: 30)
                    : const Duration(seconds: 60),
                (timer) {
                  if (Get.currentRoute == '/match') {
                    lc.refreshData(matchData);
                  } else {
                    timer.cancel();
                  }
                },
              );
            } else {
              //No need to refresh as match is finished
            }
          },
          builder: (context) {
            return TabBarView(
              children: [
                InfoTab(),
                LiveTab(
                  matchData: matchData,
                  matchStatus: matchData['match_status'] ?? 'Live',
                ),
                ExpertPicksTab(matchId: matchData['match_id'].toString()),
                CommentaryTab(),
                ScorecardTab(matchStatus: matchData['match_status']),
                SquadsTab(),
              ],
            );
          },
        ),
      ),
    );
  }
}
