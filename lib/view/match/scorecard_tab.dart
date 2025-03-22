import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/live_controller.dart';

class ScorecardTab extends StatelessWidget {
  ScorecardTab({super.key, required this.matchStatus});

  final String matchStatus;

  final LiveController lc = Get.put(LiveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: matchStatus == 'upcoming'
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    'images/waiting_clock.svg',
                    height: 100,
                    width: 100,
                  ),
                  const SizedBox(height: 4),
                  const Text("Match has not started yet"),
                ],
              ),
            )
          : Obx(
              () => lc.scorecardStatus.value == 'Loading'
                  ? Center(
                      child: Lottie.asset(
                        'images/cricket_loading.json',
                        height: 200,
                        width: 200,
                      ),
                    )
                  : lc.scorecardStatus.value == 'Loading'
                      ? const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Something went wrong'),
                            ],
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          itemCount: lc.scorecardData.length,
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          itemBuilder: (context, index) {
                            var data = lc.scorecardData[index];
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: primaryColor.withOpacity(0.5),
                                    width: 0.2),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: ExpansionTile(
                                  initiallyExpanded: true,
                                  textColor: primaryColor,
                                  iconColor: primaryColor,
                                  collapsedBackgroundColor:
                                      primaryColor.withOpacity(0.2),
                                  shape: const Border(),
                                  title: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: CachedNetworkImage(
                                          imageUrl: data['team']['flag'] ?? '',
                                          height: 24,
                                          width: 24,
                                          placeholder: (context, url) =>
                                              ColoredBox(
                                                  color: Colors.grey.shade300),
                                          errorWidget: (context, url, error) =>
                                              ColoredBox(
                                                  color: Colors.grey.shade300),
                                        ),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        "${data['team']['short_name'] ?? '-'}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "${data['team']['score']}-${data['team']['wicket']} (${data['team']['over']})",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  children: [
                                    Divider(
                                      height: 1,
                                      color: primaryColor,
                                    ),
                                    ExpansionTile(
                                      title: const Text('Batter - R, B, SR'),
                                      shape: const Border(),
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data['batsman'].length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var player = data['batsman'][index];
                                            return ListTile(
                                              dense: true,
                                              title: Text(player['name']),
                                              subtitle: Text(player['out_by']),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 35,
                                                    child: Text(
                                                        "${player['run']}"),
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                    child: Text(
                                                        "${player['ball']}"),
                                                  ),
                                                  SizedBox(
                                                    width: 45,
                                                    child: Text(
                                                        "${player['strike_rate']}"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                    ExpansionTile(
                                      title:
                                          const Text('Bowling - O, R, W, ER'),
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: data['bolwer'].length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            var player = data['bolwer'][index];
                                            return ListTile(
                                              dense: true,
                                              title: Text(player['name']),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 35,
                                                    child: Text(
                                                        "${player['over']}"),
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                    child: Text(
                                                        "${player['run']}"),
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                    child: Text(
                                                        "${player['wicket']}"),
                                                  ),
                                                  SizedBox(
                                                    width: 35,
                                                    child: Text(
                                                        "${player['economy']}"),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
    );
  }
}
