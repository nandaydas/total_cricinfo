import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/series_controller.dart';

class SeriesTableTab extends StatelessWidget {
  SeriesTableTab({super.key});

  final SeriesController sc = Get.put(SeriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => sc.seriesTableStatus.value == 'Loading'
            ? Center(
                child: Lottie.asset(
                  'images/loading.json',
                  height: 200,
                  width: 200,
                ),
              )
            : sc.seriesTableStatus.value == 'Error'
                ? const Center(
                    child: Text('Something went wrong'),
                  )
                : sc.seriesTable.isEmpty
                    ? const Center(
                        child: Text('Points Table not available !'),
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
                                  "Team",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "P",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "W",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "L",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "NR",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    "Pts",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    "NRR",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                          Scrollbar(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: sc.seriesTable.length,
                              itemBuilder: (context, index) {
                                final teamData = sc.seriesTable[index];

                                return Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      tileColor: Colors.white,
                                      title: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            child: CachedNetworkImage(
                                              imageUrl: "${teamData['flag']}",
                                              height: 24,
                                              width: 24,
                                              placeholder: (context, url) =>
                                                  ColoredBox(
                                                      color:
                                                          Colors.grey.shade300),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  ColoredBox(
                                                      color:
                                                          Colors.grey.shade300),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            "${teamData['teams']}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 30,
                                            child: Text(teamData['P'] ?? '-'),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            child: Text(teamData['W'] ?? '-'),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            child: Text(teamData['L'] ?? '-'),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            child: Text(teamData['NR'] ?? '-'),
                                          ),
                                          SizedBox(
                                            width: 30,
                                            child: Text(teamData['Pts'] ?? '-'),
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: Text(
                                              teamData['NRR'] ?? '-',
                                              textAlign: TextAlign.end,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: 1,
                                      color: primaryColor.withOpacity(0.5),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }
}
