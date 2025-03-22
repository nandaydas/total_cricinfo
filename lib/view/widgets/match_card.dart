import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import '../../controllers/ad_controller.dart';
import '../../routes/route_names.dart';

class MatchCard extends StatelessWidget {
  MatchCard({super.key, required this.matchData});
  final Map matchData;

  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.5), width: 0.2),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          adController.incrementNavigationCount();
          Get.toNamed(RouteNames.matchView, arguments: matchData);
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${matchData['matchs'] ?? ''}, ${matchData['series'] ?? ''}",
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6), fontSize: 12),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              imageUrl: "${matchData['team_a_img']}",
                              height: 20,
                              width: 20,
                              placeholder: (context, url) =>
                                  ColoredBox(color: Colors.grey.shade300),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      width: 0.8, color: primaryColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            matchData['team_a_short'] ?? '-',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 6.0),
                          matchData['match_status'] != 'Upcoming'
                              ? Text(
                                  (matchData['team_a_over'] == "") &&
                                          (matchData['match_status'] == 'Live')
                                      ? "Yet to bat"
                                      : "${matchData['team_a_scores']} ${matchData['team_a_over'].contains('&') ? '' : "(${matchData['team_a_over']})"}",
                                  style: matchData['team_a_over'] == ""
                                      ? TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600)
                                      : TextStyle(color: Colors.grey.shade800),
                                )
                              : const SizedBox()

                          // Text(matchData['currentInningsTeamName'] ==
                          //         matchData['matchScore'][0]['teamFullName']
                          //     ? '  🏏'
                          //     : ''),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              imageUrl: "${matchData['team_b_img']}",
                              height: 20,
                              width: 20,
                              placeholder: (context, url) =>
                                  ColoredBox(color: Colors.grey.shade300),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  border: Border.all(
                                      width: 0.8, color: primaryColor),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0),
                          Text(
                            matchData['team_b_short'] ?? '-',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 6.0),
                          matchData['match_status'] != 'Upcoming'
                              ? Text(
                                  (matchData['team_b_over'] == "") &&
                                          (matchData['match_status'] == 'Live')
                                      ? "Yet to bat"
                                      : "${matchData['team_b_scores']} ${matchData['team_b_over'].contains('&') ? '' : "(${matchData['team_b_over']})"}",
                                  style: matchData['team_b_over'] == ""
                                      ? TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade600)
                                      : TextStyle(color: Colors.grey.shade800),
                                )
                              : const SizedBox()
                          // Text(matchData['currentInningsTeamName'] ==
                          //         matchData['matchScore'][1]['teamFullName']
                          //     ? '  🏏'
                          //     : ''),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 50,
                    width: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                  ),
                  Container(
                    child: matchData['match_status'] == 'Live'
                        ? Row(
                            children: [
                              Lottie.asset(
                                'images/live.json',
                                height: 24,
                                width: 24,
                              ),
                              Text(
                                ' Live',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red.shade500,
                                ),
                              ),
                            ],
                          )
                        : matchData['match_status'] == 'Upcoming'
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    matchData['match_date'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    matchData['match_time'],
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              )
                            : matchData['result'].contains('won by')
                                ? Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${matchData['result'].split('won by')[0]}\nWon",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        "${matchData['result']}",
                                        textAlign: TextAlign.end,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                matchData['match_status'] == 'Finished'
                    ? matchData['result']
                    : matchData['match_status'] == 'Upcoming'
                        ? "Venue: ${matchData['venue']}"
                        : matchData['need_run_ball'] == ""
                            ? matchData['trail_lead'] == ""
                                ? matchData['toss'] == ""
                                    ? "Venue: ${matchData['venue']}"
                                    : matchData['toss']
                                : matchData['trail_lead']
                            : matchData['need_run_ball'],
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDateBasedOnToday(String timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp))
        .subtract(const Duration(hours: 5, minutes: 30));

    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime tomorrow = today.add(const Duration(days: 1));

    DateTime comparisonDate = DateTime(date.year, date.month, date.day);

    if (comparisonDate == today) {
      return 'Today';
    } else if (comparisonDate == tomorrow) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMMd').format(date);
    }
  }
}
