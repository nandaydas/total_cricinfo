import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/match_list_controller.dart';
import 'package:total_cricinfo/view/widgets/match_card.dart';

class LiveMatchList extends StatelessWidget {
  LiveMatchList({super.key});

  final MatchListController mlc = Get.put(MatchListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => mlc.liveListStatus.value == 'Loading'
            ? Center(
                child: Lottie.asset(
                  'images/loading.json',
                  height: 200,
                  width: 200,
                ),
              )
            : mlc.liveListStatus.value == 'Error'
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Something went wrong'),
                        const SizedBox(height: 4),
                        OutlinedButton(
                          onPressed: () {
                            mlc.getLiveMatchList();
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  )
                : mlc.liveMatchList.isEmpty
                    ? const Center(
                        child: Text('No matches found'),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          itemCount: mlc.liveMatchList.length,
                          itemBuilder: (context, index) {
                            final matchData = mlc.liveMatchList[index];
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
