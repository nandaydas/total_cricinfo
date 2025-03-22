import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/view/match/finished_match_list.dart';
import 'package:total_cricinfo/view/match/live_match_list.dart';
import 'package:total_cricinfo/view/match/upcoming_match_list.dart';
import '../../controllers/home_controller.dart';

class MatchesPage extends StatelessWidget {
  MatchesPage({super.key});

  final HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Matches'),
          leading: IconButton(
            onPressed: () {
              hc.selectedIndex.value = 0;
            },
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_rounded),
            ),
          ],
          bottom: TabBar(
            indicatorColor: accentColor,
            tabs: const [
              Tab(
                text: 'Live Matches',
              ),
              Tab(
                text: 'Upcoming',
              ),
              Tab(
                text: 'Results',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LiveMatchList(),
            UpcomingMatchList(),
            FinishedMatchList(),
          ],
        ),
      ),
    );
  }
}
