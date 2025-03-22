import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/live_controller.dart';
import 'package:total_cricinfo/view/widgets/commenrtary_card.dart';

class CommentaryTab extends StatelessWidget {
  CommentaryTab({super.key});

  final LiveController lc = Get.put(LiveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => lc.commentaryStatus.value == 'Loading'
            ? Center(
                child: Lottie.asset(
                  'images/loading.json',
                  height: 200,
                  width: 200,
                ),
              )
            : lc.commentaryStatus.value == 'Error'
                ? const Center(
                    child: Text('Something went wrong'),
                  )
                : lc.commentaryList.isEmpty
                    ? const Center(
                        child: Text('No Commentary found'),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          itemCount: lc
                              .commentaryList[
                                  '${lc.currentInnings.value} Inning']
                              .keys
                              .toList()
                              .length,
                          itemBuilder: (context, index) {
                            final overData = lc
                                .commentaryList[
                                    '${lc.currentInnings.value} Inning']
                                .keys
                                .toList()[index];

                            return ExpansionTile(
                              initiallyExpanded: true,
                              iconColor: primaryColor,
                              title: Text(
                                overData,
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: lc
                                      .commentaryList[
                                          '${lc.currentInnings.value} Inning']
                                          [overData]
                                      .length,
                                  itemBuilder: (context, index) {
                                    Map commentry = lc.commentaryList[
                                            '${lc.currentInnings.value} Inning']
                                        [overData][index];
                                    return commentry['type'] == 1
                                        ? CommenrtaryCard(
                                            data: commentry['data'])
                                        : const SizedBox();
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}
