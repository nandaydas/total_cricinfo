import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/match_info_controller.dart';
import 'package:total_cricinfo/routes/route_names.dart';

class InfoTab extends StatelessWidget {
  InfoTab({super.key});

  final MatchInfoController mic = Get.put(MatchInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: primaryColor.withOpacity(0.5), width: 0.2),
              ),
              margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
              padding: const EdgeInsets.all(16.0),
              child: Obx(
                () => mic.matchInfoStatus.value == 'Loading'
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : Column(
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Match Info',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ],
                          ),
                          const Divider(),
                          InkWell(
                            onTap: () {
                              Get.toNamed(
                                RouteNames.seriesView,
                                arguments: {
                                  'series': mic.matchInfo['series'],
                                  'series_id': mic.matchInfo['series_id'],
                                },
                              );
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Series',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  child: Text("${mic.matchInfo['series']}"),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: Colors.grey.shade400,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Date',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text("${mic.matchInfo['match_date']}"),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Time',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                  child: Text("${mic.matchInfo['match_time']}"))
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Toss',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text("${mic.matchInfo['toss'] ?? '-'}"),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Venue',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text("${mic.matchInfo['venue']}"),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Umpires',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child:
                                    Text("${mic.matchInfo['umpire'] ?? '-'}"),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  '3rd Umpire',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child: Text("${mic.matchInfo['third_umpire']}"),
                              )
                            ],
                          ),
                          const Divider(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 100,
                                child: Text(
                                  'Referee',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Expanded(
                                child:
                                    Text("${mic.matchInfo['referee'] ?? '-'}"),
                              )
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: primaryColor.withOpacity(0.5), width: 0.2),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Team form  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '(Last 5 matches)',
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(),
                  Obx(
                    () => mic.matchInfoStatus.value == 'Loading'
                        ? CircularProgressIndicator(color: primaryColor)
                        : mic.matchInfoStatus.value == 'Error'
                            ? const Center(
                                child: Text('Something went wrong'),
                              )
                            : Column(
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: CachedNetworkImage(
                                          imageUrl: mic.matchInfo['team_a_img'],
                                          height: 25,
                                          width: 25,
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
                                        "${mic.matchInfo['team_a_short']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      mic.matchInfo['forms']['team_a'] == null
                                          ? Text(
                                              'No Matches Found !',
                                              style: TextStyle(
                                                  color: Colors.grey.shade600),
                                            )
                                          : SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: mic
                                                    .matchInfo['forms']
                                                        ['team_a']
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  var item =
                                                      mic.matchInfo['forms']
                                                          ['team_a'][index];
                                                  return Center(
                                                    child: Container(
                                                      height: 28,
                                                      width: 28,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 6),
                                                      decoration: BoxDecoration(
                                                        color: item == 'W'
                                                            ? Colors.green
                                                                .withOpacity(
                                                                    0.1)
                                                            : Colors.red
                                                                .withOpacity(
                                                                    0.1),
                                                        border: Border.all(
                                                          color: item == 'W'
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: item == 'W'
                                                                ? Colors.green
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: CachedNetworkImage(
                                          imageUrl: mic.matchInfo['team_b_img'],
                                          height: 25,
                                          width: 25,
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
                                        "${mic.matchInfo['team_b_short']}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      mic.matchInfo['forms']['team_b'] == null
                                          ? Text(
                                              'No Matches Found !',
                                              style: TextStyle(
                                                  color: Colors.grey.shade600),
                                            )
                                          : SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: mic
                                                    .matchInfo['forms']
                                                        ['team_b']
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  var item =
                                                      mic.matchInfo['forms']
                                                          ['team_b'][index];
                                                  return Center(
                                                    child: Container(
                                                      height: 28,
                                                      width: 28,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 6),
                                                      decoration: BoxDecoration(
                                                        color: item == 'W'
                                                            ? Colors.green
                                                                .withOpacity(
                                                                    0.1)
                                                            : Colors.red
                                                                .withOpacity(
                                                                    0.1),
                                                        border: Border.all(
                                                          color: item == 'W'
                                                              ? Colors.green
                                                              : Colors.red,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          item,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: item == 'W'
                                                                ? Colors.green
                                                                : Colors.red,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                    color: primaryColor.withOpacity(0.5), width: 0.2),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'Head to Head  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        '(Last 5 matches)',
                        style: TextStyle(
                            fontSize: 16, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const Divider(),
                  Obx(
                    () => mic.matchInfoStatus.value == 'Loading'
                        ? Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : mic.matchInfo['head_to_head'] == null
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('H2H not available !'),
                                ],
                              )
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  mic.matchInfo['team_a_img'],
                                              height: 50,
                                              width: 50,
                                              placeholder: (context, url) =>
                                                  ColoredBox(
                                                      color:
                                                          Colors.grey.shade300),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            mic.matchInfo['team_a_short'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${mic.matchInfo['head_to_head']['team_a_win_count'] ?? 0}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const Text(
                                            ' - ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "${mic.matchInfo['head_to_head']['team_b_win_count'] ?? 0}",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(2),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  mic.matchInfo['team_b_img'],
                                              height: 50,
                                              width: 50,
                                              placeholder: (context, url) =>
                                                  ColoredBox(
                                                      color:
                                                          Colors.grey.shade300),
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            mic.matchInfo['team_b_short'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: mic
                                        .matchInfo['head_to_head']['matches']
                                        .length,
                                    itemBuilder: (context, index) {
                                      var item = mic.matchInfo['head_to_head']
                                          ['matches'][index];
                                      return Column(
                                        children: [
                                          const Divider(height: 1),
                                          ListTile(
                                            title: Text(
                                              "${mic.matchInfo['team_a_short']} vs ${mic.matchInfo['team_b_short']}, ${item['matchs']}",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              item['result'],
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                            trailing: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Winner',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: primaryColor),
                                                ),
                                                Text(
                                                    "${item['win_team'] == mic.matchInfo['team_a_id'].toString() ? mic.matchInfo['team_a_short'] : mic.matchInfo['team_b_short']}"),
                                              ],
                                            ),
                                          ),
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
            const SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
