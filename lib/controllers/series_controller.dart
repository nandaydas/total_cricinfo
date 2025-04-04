import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SeriesController extends GetxController {
  @override
  void onInit() {
    getSeriesList();
    super.onInit();
  }

  final RxList seriesList = [].obs;
  final RxString seriesListStatus = ''.obs;

  final RxList seriesNewsList = [].obs;
  final RxString seriesNewsStatus = ''.obs;

  final RxList<dynamic> seriesTable = <dynamic>[].obs;

  final RxString seriesTableStatus = ''.obs;

  final Map<String, String> headers = {
    'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
    'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
  };

  void getData(Map seriesData) {
    seriesTableStatus.value = 'Loading';
    seriesNewsStatus.value = 'Loading';
    Future.delayed(const Duration(seconds: 1)).then(
      (_) {
        getPointsTable(seriesData['series_id']);
      },
    );
    Future.delayed(const Duration(seconds: 2)).then(
      (_) {
        getSeriesNews(seriesData['series']);
      },
    );
  }

  Future<void> getSeriesList() async {
    seriesListStatus.value = 'Loading';

    const String url = 'https://cricket-live-line1.p.rapidapi.com/series';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        seriesList.value = data['data'];

        seriesListStatus.value = 'Success';

        getSeriesUpcomingList(seriesList[0]['series_id']);
      } else {
        log('getSeriesList Response Error: ${response.statusCode}');
        seriesListStatus.value = 'Error';
      }
    } catch (e) {
      log("getSeriesList Error: $e");
      seriesListStatus.value = 'Error';
    }
  }

  final RxList seriesUpcomingList = [].obs;
  final RxString seriesUpcomingStatus = ''.obs;

  Future<void> getSeriesUpcomingList(int seriesID) async {
    seriesUpcomingStatus.value = 'Loading';

    String url =
        'https://cricket-live-line1.p.rapidapi.com/series/$seriesID/upcomingMatches';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        seriesUpcomingList.value = data['data'];

        seriesUpcomingStatus.value = 'Success';
      } else {
        log('getSeriesMatchList Response Error: ${response.statusCode}');
        seriesUpcomingStatus.value = 'Error';
      }
    } catch (e) {
      log("getSeriesMatchList Error $e");
      seriesUpcomingStatus.value = 'Error';
    }
  }

  Future<void> getPointsTable(int seriesID) async {
    String url =
        'https://cricket-live-line1.p.rapidapi.com/series/$seriesID/pointsTable';

    Future.delayed(const Duration(seconds: 1)).then((_) async {
      try {
        final response = await http.get(Uri.parse(url), headers: headers);

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          seriesTable.value =
              data['data'] is List ? data['data'] : data['data']['A'] as List;
          seriesTableStatus.value = 'Success';
        } else {
          log('getPointsTable Response Error: ${response.statusCode}');
          seriesTableStatus.value = 'Error';
        }
      } catch (e) {
        log("getPointsTable Error: $e");
        seriesTableStatus.value = 'Error';
      }
    });
  }

  Future<void> getSeriesNews(String seriesName) async {
    String url =
        'https://api.projaat.com/series-news/${seriesName.split(',')[0]}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        seriesNewsList.value = data['newsWithContent'];
        seriesNewsStatus.value = 'Success';
      } else {
        log('getSeriesNews Response Error: ${response.statusCode}');
        seriesNewsStatus.value = 'Error';
      }
    } catch (e) {
      log("getSeriesNews Error: $e");
      seriesNewsStatus.value = 'Error';
    }
  }
}
