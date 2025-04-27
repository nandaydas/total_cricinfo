import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class PlayerInfoController extends GetxController {
  final RxMap playerInfo = {}.obs;
  final RxString playerInfoStatus = ''.obs;

  final Map<String, String> headers = {
    'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
    'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
    'x-requested-with': 'com.ukmsoftware.totalcricinfo'
  };

  Future<void> getPlayerInfo(String playerId) async {
    playerInfoStatus.value = 'Loading';
    log(playerId);
    String url = 'https://cricket-live-line1.p.rapidapi.com/player/$playerId';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        playerInfo.value = data['data'];
        playerInfoStatus.value = 'Success';
      } else {
        log('getPlayerInfo Response Error: ${response.statusCode}');
        playerInfoStatus.value = 'Error';
      }
    } catch (e) {
      log("getPlayerInfo Error: $e");
      playerInfoStatus.value = 'Error';
    }
  }
}
