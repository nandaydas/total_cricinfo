import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/match_list_controller.dart';
import 'package:total_cricinfo/view/widgets/match_card.dart';
import '../../constants/colors.dart';

class SeriesMatchesTab extends StatelessWidget {
  SeriesMatchesTab({super.key, required this.seriesId});

  final int seriesId;
  final MatchListController mlc = Get.put(MatchListController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: accentColor,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey,
            tabs: const [
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
            Obx(
              () => mlc.seriesUpcomingStatus.value == 'Loading'
                  ? Center(
                      child: Lottie.asset(
                        'images/loading.json',
                        height: 200,
                        width: 200,
                      ),
                    )
                  : mlc.seriesUpcomingStatus.value == 'Error'
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Something went wrong'),
                              const SizedBox(height: 4),
                              OutlinedButton(
                                onPressed: () {
                                  mlc.getSeriesUpcomingList(seriesId);
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        )
                      : mlc.seriesUpcomingList.isEmpty
                          ? const Center(
                              child: Text('No matches found'),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                itemCount: mlc.seriesUpcomingList.length,
                                itemBuilder: (context, index) {
                                  final matchData =
                                      mlc.seriesUpcomingList[index];
                                  return MatchCard(
                                    matchData: matchData,
                                  );
                                },
                              ),
                            ),
            ),
            Obx(
              () => mlc.seriesResultStatus.value == 'Loading'
                  ? Center(
                      child: Lottie.asset(
                        'images/loading.json',
                        height: 200,
                        width: 200,
                      ),
                    )
                  : mlc.seriesResultStatus.value == 'Error'
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text('Something went wrong'),
                              const SizedBox(height: 4),
                              OutlinedButton(
                                onPressed: () {
                                  mlc.getSeriesResultList(seriesId);
                                },
                                child: const Text('Try again'),
                              ),
                            ],
                          ),
                        )
                      : mlc.seriesResultList.isEmpty
                          ? const Center(
                              child: Text('No matches found'),
                            )
                          : Scrollbar(
                              child: ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6.0),
                                itemCount: mlc.seriesResultList.length,
                                itemBuilder: (context, index) {
                                  final matchData = mlc.seriesResultList[index];
                                  return MatchCard(
                                    matchData: matchData,
                                  );
                                },
                              ),
                            ),
            ),
          ],
        ),
      ),
    );
  }
}
