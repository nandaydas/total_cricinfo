import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/live_controller.dart';
import 'package:total_cricinfo/controllers/match_info_controller.dart';

class LiveTab extends StatelessWidget {
  LiveTab({super.key, required this.matchData, required this.matchStatus});

  final String matchStatus;
  final Map matchData;

  final LiveController lc = Get.put(LiveController());
  final MatchInfoController mic = Get.put(MatchInfoController());

  final RxDouble homeTeamPercentage = 0.0.obs;
  final RxDouble tiePercentage = 0.0.obs;
  final RxDouble awayTeamPercentage = 0.0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (lc.liveStatus.value == 'Loading') {
          return Center(
            child: Lottie.asset(
              'images/cricket_loading.json',
              height: 200,
              width: 200,
            ),
          );
        } else if (lc.liveStatus.value == 'Error') {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Something went wrong'),
                const SizedBox(height: 4),
                OutlinedButton(
                  onPressed: () {
                    lc.getData(matchData);
                  },
                  child: const Text('Try again'),
                ),
              ],
            ),
          );
        } else {
          return matchStatus == 'Upcoming'
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
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            matchStatus == 'Live'
                                ? //----------LIVE SCORE TAB----------
                                Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: CachedNetworkImage(
                                          imageUrl: lc.liveData['batting_team']
                                                      .toString() ==
                                                  lc.liveData['team_a_id']
                                                      .toString()
                                              ? lc.liveData['team_a_img']
                                              : lc.liveData['team_b_img'],
                                          height: 40,
                                          width: 40,
                                          placeholder: (context, url) =>
                                              ColoredBox(
                                                  color: Colors.grey.shade300),
                                          errorWidget: (context, url, error) =>
                                              ColoredBox(
                                                  color: Colors.grey.shade300),
                                        ),
                                      ),
                                      const SizedBox(width: 6.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${lc.liveData['batting_team'].toString() == lc.liveData['team_a_id'].toString() ? lc.liveData['team_a_short'] : lc.liveData['team_b_short'] ?? '-'}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey.shade600,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          lc.liveScore[
                                                      '${lc.currentInnings}'] ==
                                                  null
                                              ? Text(
                                                  'Yet to bat',
                                                  style: TextStyle(
                                                    color: Colors.grey.shade600,
                                                    fontSize: 18,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      "${lc.liveScore['${lc.currentInnings}']['score']}-${lc.liveScore['${lc.currentInnings}']['wicket']}",
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      " ${lc.liveScore['${lc.currentInnings}']['over']}",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            lc.liveData['last4overs'] == null
                                                ? const SizedBox()
                                                : Text(
                                                    "${lc.liveData['last4overs'].last['balls'].last}",
                                                    style: TextStyle(
                                                      color: lc
                                                                  .liveData[
                                                                      'last4overs']
                                                                  .last['balls']
                                                                  .last ==
                                                              'W'
                                                          ? Colors.red.shade600
                                                          : lc
                                                                      .liveData[
                                                                          'last4overs']
                                                                      .last[
                                                                          'balls']
                                                                      .last ==
                                                                  '6'
                                                              ? Colors.green
                                                                  .shade600
                                                              : lc
                                                                          .liveData[
                                                                              'last4overs']
                                                                          .last[
                                                                              'balls']
                                                                          .last ==
                                                                      '4'
                                                                  ? Colors.blue
                                                                      .shade600
                                                                  : Colors
                                                                      .black,
                                                      fontSize: 30,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                            Text(
                                              'Last ball',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : //----------RESULT SCORE TAB----------
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                            imageUrl: lc.liveData['team_a_img'],
                                            height: 40,
                                            width: 40,
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
                                        const SizedBox(width: 6.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${lc.liveData['team_a_short']}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              lc.liveData['team_a_scores_over'] ==
                                                      null
                                                  ? const SizedBox()
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: lc
                                                          .liveData[
                                                              'team_a_scores_over']
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final teamScore = lc
                                                                    .liveData[
                                                                'team_a_scores_over']
                                                            [index];
                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "${teamScore['score']}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              " (${teamScore['over']})",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                            ],
                                          ),
                                        ),

                                        Icon(
                                          Icons.electric_bolt,
                                          color: primaryColor,
                                        ),

                                        //----------TEAM 2----------
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "${lc.liveData['team_b_short']}",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey.shade600,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              lc.liveData['team_b_scores_over'] ==
                                                      null
                                                  ? const SizedBox()
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: lc
                                                          .liveData[
                                                              'team_b_scores_over']
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final teamScore = lc
                                                                    .liveData[
                                                                'team_b_scores_over']
                                                            [index];
                                                        return Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              "${teamScore['score']}",
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              " (${teamScore['over']})",
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 6.0),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                            imageUrl: lc.liveData['team_b_img'],
                                            height: 40,
                                            width: 40,
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
                                      ],
                                    ),
                                  ),
                            const SizedBox(height: 4),
                            //----------STATUS SECTION----------
                            const Divider(),
                            Text(
                              matchData['match_status'] == 'Finished'
                                  ? matchData['result']
                                  : matchData['match_status'] == 'Upcoming'
                                      ? "Venue: ${matchData['venue']}"
                                      : "${matchData['need_run_ball']}" == ""
                                          ? "${lc.liveData['trail_lead']}" == ""
                                              ? "${lc.liveData['toss']}"
                                              : "${lc.liveData['trail_lead'] ?? '-'}"
                                          : "${lc.liveData['need_run_ball']}",
                              style: TextStyle(color: accentColor),
                              textAlign: TextAlign.center,
                            ),
                            //----------LAST 12 BALLS----------
                            const Divider(),
                            lc.liveData['last4overs'] == null
                                ? const Text('-')
                                : SizedBox(
                                    height: 30,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      reverse: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          lc.liveData['last4overs'].length,
                                      itemBuilder: (context, index) {
                                        final overData = (lc
                                            .liveData['last4overs'].reversed
                                            .toList())[index];
                                        return Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              '   |  ',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              "Over ${overData['over']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Row(
                                              children: List.generate(
                                                  overData['balls'].length,
                                                  (innerIndex) {
                                                final ball = overData['balls']
                                                    [innerIndex];
                                                return Container(
                                                  height: 25,
                                                  width: 25,
                                                  decoration: BoxDecoration(
                                                    color: ball == 'W'
                                                        ? Colors.red
                                                        : ball == '6'
                                                            ? Colors.green
                                                            : ball == '4'
                                                                ? Colors.blue
                                                                : Colors.grey
                                                                    .shade200,
                                                    border: Border.all(
                                                      color: Colors.black
                                                          .withOpacity(0.4),
                                                      width: 0.2,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  margin: const EdgeInsets.only(
                                                      left: 4),
                                                  child: Center(
                                                    child: Text(
                                                      ball.toLowerCase(),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: ball == 'W'
                                                              ? Colors.white
                                                              : ball == '6'
                                                                  ? Colors.white
                                                                  : ball == '4'
                                                                      ? Colors
                                                                          .white
                                                                      : Colors
                                                                          .black,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                            Text(
                                              "  = ${overData['runs']}",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),

                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      'CRR: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text("${lc.liveData['curr_rate'] ?? 0}"),
                                  ],
                                ),
                                Visibility(
                                  visible: lc.liveData['rr_rate'] != null,
                                  child: Row(
                                    children: [
                                      const Text(
                                        'RRR: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${lc.liveData['rr_rate']}")
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: lc.liveData['target'] != null,
                                  child: Row(
                                    children: [
                                      const Text(
                                        'Target: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${lc.liveData['target']}")
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: primaryColor.withOpacity(0.5),
                      ),
                      const SizedBox(height: 6),
                      //-----ONLY SHOWING WHEN MATCH FINISHED & PLAYER OF MATCH AVAILABLE-----
                      mic.matchInfo['man_of_match_player'] == ''
                          ? const SizedBox()
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: primaryColor.withOpacity(0.5),
                                    width: 0.2),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Player of the Match',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                      ),
                                      Text(
                                        '${mic.matchInfo['man_of_match_player']}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                      // -----ONLY SHOWING WHEN MATCH LIVE & DATA AVAILABLE-----
                      matchData['match_status'] != 'Live'
                          ? const SizedBox()
                          : lc.liveData['max_rate'] == 0
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: primaryColor.withOpacity(0.5),
                                        width: 0.2),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${matchData['team_a_short']}",
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            "${matchData['team_a_short'] == lc.liveData['fav_team'] ? ((1 / lc.liveData['max_rate']) * 100).toStringAsFixed(0) : (100 - (1 / lc.liveData['max_rate']) * 100).toStringAsFixed(0)}%",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            const Text(
                                              'Realtime Win %',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 8),
                                              child: CombinedProgressBar(
                                                values: [
                                                  matchData['team_a_short'] ==
                                                          lc.liveData[
                                                              'fav_team']
                                                      ? ((1 /
                                                              lc.liveData[
                                                                  'max_rate']) *
                                                          100)
                                                      : (100 -
                                                          (1 /
                                                                  lc.liveData[
                                                                      'max_rate']) *
                                                              100),
                                                  tiePercentage.value,
                                                  matchData['team_b_short'] ==
                                                          lc.liveData[
                                                              'fav_team']
                                                      ? ((1 /
                                                              lc.liveData[
                                                                  'max_rate']) *
                                                          100)
                                                      : (100 -
                                                          (1 /
                                                                  lc.liveData[
                                                                      'max_rate']) *
                                                              100),
                                                ], // Percentages in decimals (30%, 50%, 20%)
                                                colors: [
                                                  primaryColor,
                                                  Colors.grey.shade300,
                                                  accentColor
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${matchData['team_b_short']}",
                                            style: TextStyle(
                                                color: Colors.grey.shade600),
                                          ),
                                          Text(
                                            "${matchData['team_b_short'] == lc.liveData['fav_team'] ? ((1 / lc.liveData['max_rate']) * 100).toStringAsFixed(0) : (100 - (1 / lc.liveData['max_rate']) * 100).toStringAsFixed(0)}%",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
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
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Batsman',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 60,
                                  child: Text(
                                    'R(B)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    '4s',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: Text(
                                    '6s',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    'SR',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6.0),
                            lc.liveData['batsman'] != null &&
                                    lc.liveData['batsman'].length < 1 //TODO
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Text(
                                        "${lc.liveData['batsman'][0]['name']}",
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          "${lc.liveData['batsman'][0]['run']}(${lc.liveData['batsman'][0]['ball']})",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          "${lc.liveData['batsman'][0]['fours'] ?? 0}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          "${lc.liveData['batsman'][0]['sixes'] ?? 0}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "${lc.liveData['batsman'][0]['strike_rate'] ?? '-'}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 4),
                            lc.liveData['batsman'] != null &&
                                    lc.liveData['batsman'].length < 2 //TODO
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Text(
                                        "${lc.liveData['batsman'][1]['name']}",
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 60,
                                        child: Text(
                                          "${lc.liveData['batsman'][1]['run']}(${lc.liveData['batsman'][1]['ball']})",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          "${lc.liveData['batsman'][1]['fours'] ?? 0}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: Text(
                                          "${lc.liveData['batsman'][1]['sixes'] ?? 0}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "${lc.liveData['batsman'][1]['strike_rate'] ?? '-'}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 4.0),
                            lc.liveData['partnership'] == null
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Text(
                                        "P'ship: ${lc.liveData['partnership']['run']} (${lc.liveData['partnership']['ball']})",
                                        style: TextStyle(
                                            color: Colors.grey.shade600),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 4.0),
                            const Divider(),
                            const SizedBox(height: 4.0),
                            const Row(
                              children: [
                                Text(
                                  'Bowler',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                  textAlign: TextAlign.end,
                                ),
                                Spacer(),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    'W-R',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Overs',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                  child: Text(
                                    'Econ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            lc.liveData['bolwer'] == null
                                ? const SizedBox()
                                : Row(
                                    children: [
                                      Text(
                                        "${lc.liveData['bolwer']['name'] ?? '-'}",
                                        textAlign: TextAlign.end,
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "${lc.liveData['bolwer']['run'] ?? 0}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "${lc.liveData['bolwer']['over'] ?? 0}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          "${lc.liveData['bolwer']['economy'] ?? '-'}",
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      lc.liveData['projected_score'] == null
                          ? const SizedBox()
                          : lc.liveData['projected_score'].length == 0
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: primaryColor.withOpacity(0.5),
                                        width: 0.2),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            'Projected Score',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                          Text(
                                            'as per RR*',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade600),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 2, top: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Run Rate",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade600),
                                                ),
                                                const Spacer(),
                                                SizedBox(
                                                  width: 40,
                                                  child: Text(
                                                    "${lc.liveData['projected_score'][0]['cur_rate']}*",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                  child: Text(
                                                    "${lc.liveData['projected_score'][0]['cur_rate_1']}",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                  child: Text(
                                                    "${lc.liveData['projected_score'][0]['cur_rate_2']}",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 40,
                                                  child: Text(
                                                    "${lc.liveData['projected_score'][0]['cur_rate_3']}",
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: lc
                                                .liveData['projected_score']
                                                .length,
                                            itemBuilder: (context, index) {
                                              var item =
                                                  lc.liveData['projected_score']
                                                      [index];
                                              return Column(
                                                children: [
                                                  const Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 2),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "${item['over']} Over",
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: const TextStyle(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        const Spacer(),
                                                        SizedBox(
                                                          width: 40,
                                                          child: Text(
                                                            "${item['cur_rate_score']}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          child: Text(
                                                            "${item['cur_rate_1_score']}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          child: Text(
                                                            "${item['cur_rate_2_score']}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          child: Text(
                                                            "${item['cur_rate_3_score']}",
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                      const SizedBox(height: 6),
                    ],
                  ),
                );
        }
      }),
    );
  }
}

class CombinedProgressBar extends StatelessWidget {
  final List<double> values; // Values should sum up to <= 1.0
  final List<Color> colors; // Colors for each segment

  const CombinedProgressBar({
    super.key,
    required this.values,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    assert(values.length == colors.length,
        "Values and colors must have the same length");

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Container(
        height: 6,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: Row(
          children: values.asMap().entries.map((entry) {
            int index = entry.key;
            double value = entry.value;

            return Flexible(
              flex: (value * 1000)
                  .toInt(), // Multiply by 1000 to proportion the widths
              child: Container(
                color: colors[index],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
