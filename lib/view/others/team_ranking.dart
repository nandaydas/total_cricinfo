import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/ranking_controller.dart';
import '../../constants/colors.dart';

class TeamRanking extends StatelessWidget {
  TeamRanking({super.key});

  final RankingController rc = Get.put(RankingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Ranking'),
      ),
      body: Obx(
        () => rc.teamRankingStatus.value == 'Loading'
            ? Center(
                child: Lottie.asset(
                  'images/loading.json',
                  height: 200,
                  width: 200,
                ),
              )
            : Scrollbar(
                child: ListView.builder(
                  itemCount: rc.teamRankingList.length,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  itemBuilder: (context, index) {
                    var item = rc.teamRankingList[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: primaryColor.withOpacity(0.5), width: 0.2),
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Text(
                              "${item['rank']}.",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(width: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl: "${item['flag']}",
                                height: 50,
                                width: 50,
                                placeholder: (context, url) =>
                                    ColoredBox(color: Colors.grey.shade300),
                                errorWidget: (context, url, error) =>
                                    ColoredBox(color: Colors.grey.shade300),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${item['team']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Text(
                                    "Points: ${item['point']},  Rating: ${item['rating']}")
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}
