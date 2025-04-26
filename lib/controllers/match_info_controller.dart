import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class MatchInfoController extends GetxController {
  final RxString matchInfoStatus = ''.obs;
  final RxMap matchInfo = {}.obs;

  final RxString matchSquadsStatus = ''.obs;
  final RxMap matchSquads = {}.obs;

  // final RxString matchH2hStatus = ''.obs;
  // final RxList matchH2h = [].obs;

  void getData(int matchId) {
    getMatchInfo(matchId);

    getMatchSquads(matchId);

    // getMatchH2h(matchId);
  }

  Future<void> getMatchInfo(int matchId) async {
    matchInfoStatus.value = 'Loading';

    final Map<String, String> headers = {
      'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
      'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
      'x-requested-with': 'com.ukmsoftware.totalcricinfo'
    };

    String url = 'https://cricket-live-line1.p.rapidapi.com/match/$matchId';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        matchInfo.value = data['data'];
        matchInfoStatus.value = 'Success';
      } else {
        log('getMatchInfo Response Error: ${response.statusCode}');
        matchInfoStatus.value = 'Error';
      }
    } catch (e) {
      log("getMatchInfo Error: $e");
      matchInfoStatus.value = 'Error';
    }
  }

  Future<void> getMatchSquads(int matchId) async {
    matchSquadsStatus.value = 'Loading';

    final Map<String, String> headers = {
      'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
      'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
      'x-requested-with': 'com.ukmsoftware.totalcricinfo'
    };

    String url =
        'https://cricket-live-line1.p.rapidapi.com/match/$matchId/squads';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        matchSquads.value = data['data'];
        matchSquadsStatus.value = 'Success';
      } else {
        log('getMatchSquads Response Error: ${response.statusCode}');
        matchSquadsStatus.value = 'Error';
      }
    } catch (e) {
      log("getMatchSquads Error: $e");
      matchSquadsStatus.value = 'Error';
    }
  }

  // Future<void> getMatchH2h(int matchId) async {
  //   matchH2hStatus.value = 'Loading';

  //   final Map<String, String> headers = {
  //     'x-rapidapi-key': rapidApiKey,
  //     'x-rapidapi-host': 'cricket-buzz-api.p.rapidapi.com',
  //   };

  //   String url =
  //       'https://cricket-buzz-api.p.rapidapi.com/api/cricket/v1/match/team-head2head?matchId=$matchId';

  //   Future.delayed(const Duration(seconds: 2)).then((_) async {
  //     try {
  //       final response = await http.get(Uri.parse(url), headers: headers);

  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         matchH2h.value = data['response']['lastFiveH2H'];
  //         matchH2hStatus.value = 'Success';
  //       } else {
  //         log('getMatchH2h Response Error: ${response.statusCode}');
  //         matchH2hStatus.value = 'Error';
  //       }
  //     } catch (e) {
  //       log("getMatchH2h Error: $e");
  //       matchH2hStatus.value = 'Error';
  //     }
  //   });
  // }

  // Future<void> getMatchLast5(int matchId) async {
  //   matchLastStatus.value = 'Loading';

  //   final Map<String, String> headers = {
  //     'x-rapidapi-key': rapidApiKey,
  //     'x-rapidapi-host': 'cricket-buzz-api.p.rapidapi.com',
  //   };

  //   String url =
  //       'https://cricket-buzz-api.p.rapidapi.com/api/cricket/v1/match/team-last-five?matchId=$matchId';

  //   Future.delayed(const Duration(seconds: 1)).then((_) async {
  //     try {
  //       final response = await http.get(Uri.parse(url), headers: headers);

  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         matchLast.value = data['response'];
  //         matchLastStatus.value = 'Success';
  //       } else {
  //         log('getMatchLast5 Response Error: ${response.statusCode}');
  //         matchLastStatus.value = 'Error';
  //       }
  //     } catch (e) {
  //       log("getMatchLast5 Error: $e");
  //       matchLastStatus.value = 'Error';
  //     }
  //   });
  // }
}
