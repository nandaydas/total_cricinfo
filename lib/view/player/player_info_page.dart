import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/player_info_controller.dart';

import '../../controllers/ad_controller.dart';

final PlayerInfoController pic = Get.put(PlayerInfoController());

class PlayerInfoPage extends StatelessWidget {
  PlayerInfoPage({super.key, required this.playerId});

  final String playerId;

  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    pic.getPlayerInfo(playerId);

    Future.delayed(Duration.zero, () {
      adController.loadBannerAd();
    });
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Obx(
            () => Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: "${pic.playerInfo['player']['image']}",
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${pic.playerInfo['player']['name']}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${pic.playerInfo['teams'] ?? 'Loading...'}",
                        maxLines: 1,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            indicatorColor: accentColor,
            tabs: const [
              Tab(
                text: 'Player Info',
              ),
              Tab(
                text: 'Batting',
              ),
              Tab(
                text: 'Bowling',
              ),
            ],
          ),
        ),
        bottomNavigationBar: Obx(() {
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
        }),
        body: TabBarView(
          children: [
            Obx(
              () => pic.playerInfoStatus.value == 'Loading'
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : Scrollbar(
                      radius: const Radius.circular(100),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 6.0),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                    width: 0.2),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Birth place',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(pic.playerInfo['player']
                                              ['birth_place']))
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Born',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(pic.playerInfo['player']['born'])
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Height',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(pic.playerInfo['player']['height'] ??
                                          '-')
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Player role',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(
                                          pic.playerInfo['player']['play_role'])
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Bowling style',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(pic.playerInfo['player']
                                          ['style_bowling'])
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 100,
                                        child: Text(
                                          'Batting style',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(pic.playerInfo['player']
                                          ['style_bating'])
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            pic.playerInfo['player']['description'] == ""
                                ? const SizedBox()
                                : Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.2),
                                          width: 0.2),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    padding: const EdgeInsets.all(16),
                                    child: HtmlWidget(
                                      "${pic.playerInfo['player']['description']}",
                                      enableCaching: true,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
            ),
            //----------BATTING----------
            Obx(
              () => pic.playerInfoStatus.value == 'Loading'
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : pic.playerInfoStatus.value == 'Error'
                      ? const Center(
                          child: Text('Not available !'),
                        )
                      : Column(
                          children: [
                            Container(
                              color: primaryColor.withOpacity(0.1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: const Row(
                                children: [
                                  Text(
                                    "Type",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Mat",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Inns",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "100's",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "4's",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "6's",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Runs",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: primaryColor.withOpacity(0.5),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  pic.playerInfo['batting_career'].length,
                              itemBuilder: (context, index) {
                                var item =
                                    pic.playerInfo['batting_career'][index];
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 12, 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${item['match_type']}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['matches']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['inning']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['hundreds']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['fours']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['sixes']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['runs']}",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.2),
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
            ),
            Obx(
              () => pic.playerInfoStatus.value == 'Loading'
                  ? Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    )
                  : pic.playerInfoStatus.value == 'Error'
                      ? const Center(
                          child: Text('Not available !'),
                        )
                      : Column(
                          children: [
                            Container(
                              color: primaryColor.withOpacity(0.1),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: const Row(
                                children: [
                                  Text(
                                    "Type",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Mat",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Inns",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Econ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Wkts",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Balls",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 45,
                                    child: Text(
                                      "Runs",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: primaryColor.withOpacity(0.5),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  pic.playerInfo['bowling_career'].length,
                              itemBuilder: (context, index) {
                                var item =
                                    pic.playerInfo['bowling_career'][index];
                                return Column(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 16, 12, 16),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${item['match_type']}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['matches']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['inning']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['economy']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['wkts']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['balls']}",
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 45,
                                            child: Text(
                                              "${item['runs']}",
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: Colors.black.withOpacity(0.2),
                                    )
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
