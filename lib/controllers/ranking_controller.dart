import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import '../constants/api_key.dart';
import 'package:http/http.dart' as http;

class RankingController extends GetxController {
  final RxList teamRankingList = [].obs;
  final RxString teamRankingStatus = "".obs;

  final RxList playerRankingList = [].obs;
  final RxString playerRankingStatus = "".obs;

  final Map<String, String> headers = {
    'x-rapidapi-key': rapidApiKey,
    'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
  };

  @override
  void onInit() {
    getPlayerRanking();
    getTeamRanking();
    super.onInit();
  }

  Future<void> getPlayerRanking() async {
    playerRankingStatus.value = 'Loading';

    const String url =
        'https://cricket-live-line1.p.rapidapi.com/playerRanking/1';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        playerRankingList.value = data['data'];
        playerRankingStatus.value = 'Success';
      } else {
        log('getPlayerRanking Response Error: ${response.statusCode}');
        playerRankingStatus.value = 'Error';
      }
    } catch (e) {
      log("getPlayerRanking Error: $e");
      playerRankingStatus.value = 'Error';
    }
  }

  Future<void> getTeamRanking() async {
    teamRankingStatus.value = 'Loading';

    const String url =
        'https://cricket-live-line1.p.rapidapi.com/teamRanking/1';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        teamRankingList.value = data['data'];
        teamRankingStatus.value = 'Success';
      } else {
        log('getTeamRanking Response Error: ${response.statusCode}');
        teamRankingStatus.value = 'Error';
      }
    } catch (e) {
      log("getTeamRanking Error: $e");
      teamRankingStatus.value = 'Error';
    }
  }
}
