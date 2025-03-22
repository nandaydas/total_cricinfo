import 'package:flutter/material.dart';
import 'package:total_cricinfo/constants/colors.dart';

class CommenrtaryCard extends StatelessWidget {
  const CommenrtaryCard({super.key, required this.data});

  final Map data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.5), width: 0.1),
      ),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                data['overs'] ?? '',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Container(
                decoration: BoxDecoration(
                  color: data['wicket'] == 1
                      ? accentColor
                      : data['runs'] == '6'
                          ? Colors.green
                          : data['runs'] == '4'
                              ? Colors.blue.shade600
                              : Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  data['wicket'] == 1 ? 'W' : data['runs'],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: data['wicket'] == 1
                        ? Colors.white
                        : data['runs'] == '6'
                            ? Colors.white
                            : data['runs'] == '4'
                                ? Colors.white
                                : Colors.black,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['title'] ?? '-',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  data['description'] ?? '-',
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return data['ballType'] == 'summary'
    //     ? //----------SUMMARY CARD----------
    //     Container(
    //         decoration: BoxDecoration(
    //           color: primaryColor.withOpacity(0.1),
    //           borderRadius: BorderRadius.circular(10.0),
    //           border:
    //               Border.all(color: primaryColor.withOpacity(0.4), width: 0.2),
    //         ),
    //         margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    //         padding: const EdgeInsets.all(16.0),
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 const Text(
    //                   'Summary',
    //                   style:
    //                       TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    //                 ),
    //                 Text(
    //                   '${data['teamShortName']} ${data['score']}',
    //                   style: const TextStyle(
    //                       fontSize: 14, fontWeight: FontWeight.bold),
    //                 ),
    //               ],
    //             ),
    //             Divider(color: primaryColor.withOpacity(0.8)),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Row(
    //                       children: [
    //                         Text(
    //                           "${data['batsmen'][0]['batsmanName']}   ",
    //                           style:
    //                               const TextStyle(fontWeight: FontWeight.w600),
    //                         ),
    //                         Text(
    //                             "${data['batsmen'][0]['runs']}(${data['batsmen'][0]['balls']}) ${data['batsmen'][0]['onStrike'] == true ? '🏏' : ''}"),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 2),
    //                     Row(
    //                       children: [
    //                         Text(
    //                           "${data['batsmen'][1]['batsmanName']}   ",
    //                           style:
    //                               const TextStyle(fontWeight: FontWeight.w600),
    //                         ),
    //                         Text(
    //                             "${data['batsmen'][1]['runs']}(${data['batsmen'][0]['balls']}) ${data['batsmen'][1]['onStrike'] == true ? '🏏' : ''}"),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 Column(
    //                   crossAxisAlignment: CrossAxisAlignment.end,
    //                   children: [
    //                     Text(
    //                       data['bowler'][0]['bowlerName'],
    //                       style: const TextStyle(fontWeight: FontWeight.w600),
    //                     ),
    //                     Text(
    //                         "${data['bowler'][0]['overs']}-${data['bowler'][0]['maidens']}-${data['bowler'][0]['runs']}-${data['bowler'][0]['wickets']}"),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       )
    //     : data['ballType'] == 'wicketWidget'
    //         ? //----------WICKET CARD----------
    //         Container(
    //             decoration: BoxDecoration(
    //               color: accentColor.withOpacity(0.2),
    //               borderRadius: BorderRadius.circular(10.0),
    //               border: Border.all(
    //                   color: accentColor.withOpacity(0.4), width: 0.2),
    //             ),
    //             margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    //             padding: const EdgeInsets.all(16.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     const Text(
    //                       'Wicket !',
    //                       style: TextStyle(
    //                           fontSize: 14, fontWeight: FontWeight.bold),
    //                     ),
    //                     Text(
    //                       '${data['batsmanName']} - ${data['playerDetails']['playerMatchRuns']}(${data['playerDetails']['playerMatchBalls']})',
    //                       style: const TextStyle(
    //                           fontSize: 14, fontWeight: FontWeight.bold),
    //                     ),
    //                   ],
    //                 ),
    //                 Divider(color: accentColor.withOpacity(0.8)),
    //                 Text("${data['bowlerName']} to ${data['batsmanName']}"),
    //                 const SizedBox(height: 2),
    //                 Text(
    //                   data['wicketType'].toString().toUpperCase(),
    //                   style: const TextStyle(fontWeight: FontWeight.bold),
    //                 ),
    //               ],
    //             ),
    //           )
    //         : //----------COMMENTARY CARD----------
    //         Container(
    //             decoration: BoxDecoration(
    //               color: Colors.white,
    //               borderRadius: BorderRadius.circular(12),
    //               border: Border.all(
    //                   color: Colors.black.withOpacity(0.2), width: 0.1),
    //             ),
    //             margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    //             padding: const EdgeInsets.all(16.0),
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Column(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Text(
    //                       data['over'] ?? '',
    //                       style: const TextStyle(
    //                           fontSize: 12, fontWeight: FontWeight.bold),
    //                     ),
    //                     const SizedBox(height: 8.0),
    //                     data['wicket'] == true
    //                         ? Container(
    //                             decoration: BoxDecoration(
    //                                 color: accentColor, shape: BoxShape.circle),
    //                             padding: const EdgeInsets.all(4.0),
    //                             child: const Text(
    //                               'W',
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 14,
    //                                 fontWeight: FontWeight.bold,
    //                               ),
    //                             ),
    //                           )
    //                         : Visibility(
    //                             visible: data['runs'] != null,
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                   color: data['runs'] == '6'
    //                                       ? Colors.green.shade600
    //                                       : Colors.grey.shade300,
    //                                   shape: BoxShape.circle),
    //                               padding: const EdgeInsets.all(6.0),
    //                               child: Text(
    //                                 data['runs'] ?? '',
    //                                 style: TextStyle(
    //                                   color: data['runs'] == '6'
    //                                       ? Colors.white
    //                                       : Colors.black,
    //                                   fontSize: 14,
    //                                   fontWeight: FontWeight.bold,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                   ],
    //                 ),
    //                 Visibility(
    //                     visible: data['over'] != null || data['runs'] != null,
    //                     child: const SizedBox(width: 8.0)),
    //                 Expanded(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Visibility(
    //                         visible: data['ballType'] == 'ball',
    //                         child: Text(
    //                             "${data['bowlerName']} to ${data['batsmanName']}"),
    //                       ),
    //                       const SizedBox(height: 2),
    //                       Text(
    //                         data['commentary'] ?? '',
    //                         style: const TextStyle(fontWeight: FontWeight.w600),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
  }
}
