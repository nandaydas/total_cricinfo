import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LiveController extends GetxController {
  final RxString liveStatus = ''.obs;
  final RxMap<String, dynamic> liveData = <String, dynamic>{}.obs;
  final RxMap liveScore = {}.obs;
  final RxString currentInnings = '1'.obs;

  final RxList scorecardData = [].obs;
  final RxString scorecardStatus = ''.obs;

  final RxMap commentaryList = {}.obs;
  final RxString commentaryStatus = ''.obs;

  final RxList<Map> fancyData = <Map>[].obs;
  final RxString fancyStatus = ''.obs;

  final Map<String, String> headers = {
    'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
    'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
  };

  void getData(Map matchData) {
    liveStatus.value = 'Loading';
    scorecardStatus.value = 'Loading';
    commentaryStatus.value = 'Loading';
    getLiveData(matchData['match_id']);
    getScorecard(matchData['match_id']);
    getCommentary(matchData['match_id']);
  }

  void refreshData(Map matchData) {
    log('Refreshing...');
    getLiveData(matchData['match_id']);
    getScorecard(matchData['match_id']);
    getCommentary(matchData['match_id']);
  }

  Future<void> getLiveData(int matchId) async {
    //FOR LIVE TAB

    String url =
        'https://cricket-live-line1.p.rapidapi.com/match/$matchId/liveLine';
    log(matchId.toString());

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        liveData.value = data['data'] as Map<String, dynamic>;

        currentInnings.value = (liveData['current_inning'] ?? 1).toString();

        liveScore.value = liveData['batting_team'].toString() ==
                liveData['team_a_id'].toString()
            ? liveData['team_a_score'] ?? {}
            : liveData['team_b_score'] ?? {};
        liveStatus.value = 'Success';
      } else {
        log('getLiveData Response Error: ${response.statusCode}');
        liveStatus.value = 'Error';
      }
    } catch (e) {
      log("getLiveData Error: $e");
      liveStatus.value = 'Error';
    }
  }

  Future<void> getScorecard(int matchId) async {
    //FOR SCORECARD TAB
    log(matchId.toString());

    String url =
        'https://cricket-live-line1.p.rapidapi.com/match/$matchId/scorecard';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // scorecardData.value = data['response'];

        scorecardData.addAll(
            (data['data']['scorecard'] as Map<String, dynamic>?)?.values ?? []);

        scorecardStatus.value = 'Success';
      } else {
        log('getScorecard Response Error: ${response.statusCode}');

        scorecardStatus.value = 'Error';
      }
    } catch (e) {
      log("getScorecard Error: $e");
      scorecardStatus.value = 'Error';
    }
  }

  void getCommentary(int matchId) async {
    final Map<String, String> headers = {
      'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
      'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
    };

    String url =
        'https://cricket-live-line1.p.rapidapi.com/match/$matchId/commentary';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        commentaryList.value = data['data'];
        commentaryStatus.value = 'Success';
      } else {
        log('getLiveMatchList Response Error: ${response.statusCode}');
        commentaryStatus.value = 'Error';
      }
    } catch (e) {
      log("getCommentary Error: $e");
      commentaryStatus.value = 'Error';
    }
  }

  // void getFancy(int matchId) async {
  //   log("Getting fancy for $matchId");

  //   String url =
  //       'https://cricket-live-line1.p.rapidapi.com/match/$matchId/fancy';

  //   try {
  //     final response = await http.get(Uri.parse(url), headers: headers);

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       fancyData.value = [];
  //       fancyData.value = (data['data'] as List)
  //           .cast<Map<dynamic, dynamic>>()
  //           .reversed
  //           .toList();

  //       fancyStatus.value = 'Success';
  //       log("Got fancy for $matchId");
  //     } else {
  //       log('getFancy Response Error: ${response.statusCode}');
  //       fancyStatus.value = 'Error';
  //     }
  //   } catch (e) {
  //     log("getFancy Error: $e");
  //     fancyStatus.value = 'Error';
  //   }
  // }
}
