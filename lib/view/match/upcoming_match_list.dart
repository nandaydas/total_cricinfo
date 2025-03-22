import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/match_list_controller.dart';
import '../widgets/match_card.dart';

class UpcomingMatchList extends StatelessWidget {
  UpcomingMatchList({super.key});

  final MatchListController mlc = Get.put(MatchListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => mlc.upcomingListStatus.value == 'Loading'
            ? Center(
                child: Lottie.asset(
                  'images/loading.json',
                  height: 200,
                  width: 200,
                ),
              )
            : mlc.upcomingListStatus.value == 'Error'
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Something went wrong'),
                        const SizedBox(height: 4),
                        OutlinedButton(
                          onPressed: () {
                            mlc.getUpcomingMatchList();
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  )
                : mlc.upcomingMatchList.isEmpty
                    ? const Center(
                        child: Text('No matches found'),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          itemCount: mlc.upcomingMatchList.length,
                          itemBuilder: (context, index) {
                            final matchData = mlc.upcomingMatchList[index];
                            return MatchCard(
                              matchData: matchData,
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}
