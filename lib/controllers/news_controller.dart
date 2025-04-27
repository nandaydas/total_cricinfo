import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NewsController extends GetxController {
  @override
  void onInit() {
    getNewsList();
    super.onInit();
  }

  final RxString newsStatus = ''.obs;
  final RxList newsList = [].obs;

  final RxList newsSubList = [].obs;

  final Map<String, String> headers = {
    'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
    'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
    'x-requested-with': 'com.ukmsoftware.totalcricinfo'
  };

  Future<void> getNewsList() async {
    newsStatus.value = 'Loading';

    const String url = 'https://cricket-live-line1.p.rapidapi.com/news';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final data = jsonDecode(decoded);
        newsList.value = data['data'];
        newsSubList.value = newsList.sublist(5, 5 + 5);
        newsStatus.value = 'Success';
      } else {
        log('getNewsList Response Error: ${response.statusCode}');
        newsStatus.value = 'Error';
      }
    } catch (e) {
      log("getNewsList Error: $e");
      newsStatus.value = 'Error';
    }
  }
}
