import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/match_info_controller.dart';
import 'package:total_cricinfo/view/widgets/player_card.dart';

class SquadsTab extends StatelessWidget {
  SquadsTab({super.key});

  final MatchInfoController mic = Get.put(MatchInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => mic.matchInfoStatus.value == 'Loading'
            ? Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : mic.matchInfoStatus.value == 'Error'
                ? const Center(
                    child: Text('Squads not available at this moment'),
                  )
                : Scrollbar(
                    radius: const Radius.circular(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: primaryColor.withOpacity(0.1),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: CachedNetworkImage(
                                    imageUrl: mic.matchInfo['team_a_img'],
                                    height: 20,
                                    width: 20,
                                    placeholder: (context, url) =>
                                        ColoredBox(color: Colors.grey.shade300),
                                    errorWidget: (context, url, error) =>
                                        ColoredBox(color: Colors.grey.shade300),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  "${mic.matchInfo['team_a_short']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.electric_bolt,
                                  color: primaryColor,
                                ),
                                const Spacer(),
                                Text(
                                  "${mic.matchInfo['team_b_short']}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 8.0),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(2),
                                  child: CachedNetworkImage(
                                    imageUrl: mic.matchInfo['team_b_img'],
                                    height: 20,
                                    width: 20,
                                    placeholder: (context, url) =>
                                        ColoredBox(color: Colors.grey.shade300),
                                    errorWidget: (context, url, error) =>
                                        ColoredBox(color: Colors.grey.shade300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: primaryColor.withOpacity(0.5),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: mic.matchSquads['team_a']['player']
                                              .length ==
                                          0
                                      ? const Center(
                                          child: Text('Squads not avaiable'),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: mic
                                              .matchSquads['team_a']['player']
                                              .length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var player =
                                                mic.matchSquads['team_a']
                                                    ['player'][index];
                                            return PlayerCard(
                                              player: player,
                                              margin: const EdgeInsets.fromLTRB(
                                                  12, 6, 6, 6),
                                              color: primaryColor,
                                            );
                                          },
                                        ),
                                ),
                                Expanded(
                                  child: mic.matchSquads['team_b']['player']
                                              .length ==
                                          0
                                      ? const Center(
                                          child: Text('Squads not avaiable'),
                                        )
                                      : ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: mic
                                              .matchSquads['team_b']['player']
                                              .length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            var player =
                                                mic.matchSquads['team_b']
                                                    ['player'][index];
                                            return PlayerCard(
                                              player: player,
                                              margin: const EdgeInsets.fromLTRB(
                                                  6, 6, 12, 6),
                                              color: accentColor,
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
