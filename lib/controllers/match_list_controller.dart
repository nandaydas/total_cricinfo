import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MatchListController extends GetxController {
  @override
  void onInit() {
    getFeaturedMatchList();
    getLiveMatchList();
    getUpcomingMatchList();
    getFinishedMatchList();
    super.onInit();
  }

  final RxString featuredListStatus = ''.obs;
  final RxString liveListStatus = ''.obs;
  final RxString upcomingListStatus = ''.obs;
  final RxString finishedListStatus = ''.obs;

  final RxList featuredMatchList = [].obs;
  final RxList liveMatchList = [].obs;
  final RxList upcomingMatchList = [].obs;
  final RxList finishedMatchList = [].obs;

  final RxList seriesResultList = [].obs;

  final RxString seriesResultStatus = ''.obs;

  final Map<String, String> headers = {
    'x-rapidapi-key': "${dotenv.env['rapidApiKey']}",
    'x-rapidapi-host': 'cricket-live-line1.p.rapidapi.com',
    'x-requested-with': 'com.ukmsoftware.totalcricinfo'
  };

  Future<void> getLiveMatchList() async {
    liveListStatus.value = 'Loading';

    const String url =
        'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=oIa1RHGHYILtHo45I6YTH7CTqHGfywRDfaZJHeGFtynIucVzfzSMXR0OlrQU&filter[status]=Live&include=localTeam,visitorTeam,league,venue,tosswon';

    Future.delayed(const Duration(seconds: 1)).then(
      (_) async {
        try {
          final response = await http.get(Uri.parse(url), headers: headers);

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);

            liveMatchList.value = data['data'].isEmpty ? [] : data['data'];
            liveListStatus.value = 'Success';
          } else {
            log('getLiveMatchList Response Error: ${response.statusCode}');
            liveListStatus.value = 'Error';
          }
        } catch (e) {
          log("getLiveMatchList Error: $e");
          liveListStatus.value = 'Error';
        }
      },
    );
  }

  Future<void> getUpcomingMatchList() async {
    upcomingListStatus.value = 'Loading';
    const String url =
        'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=oIa1RHGHYILtHo45I6YTH7CTqHGfywRDfaZJHeGFtynIucVzfzSMXR0OlrQU&filter[status]=NS&include=localTeam,visitorTeam,league,venue,tosswon';

    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        try {
          final response = await http.get(Uri.parse(url));

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            upcomingMatchList.value = data['data'];
            // upcomingMatchList
            //     .sort((a, b) => a["startDate"].compareTo(b["startDate"]));

            upcomingListStatus.value = 'Success';
          } else {
            log('getUpcomingMatchList Response Error: ${response.statusCode}');
            upcomingListStatus.value = 'Error';
          }
        } catch (e) {
          log("getUpcomingMatchList Error $e");
          upcomingListStatus.value = 'Error';
        }
      },
    );
  }

  Future<void> getFinishedMatchList() async {
    finishedListStatus.value = 'Loading';

    const String url =
        'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=oIa1RHGHYILtHo45I6YTH7CTqHGfywRDfaZJHeGFtynIucVzfzSMXR0OlrQU&filter[status]=Finished&include=localTeam,visitorTeam,league,venue,tosswon';

    Future.delayed(const Duration(seconds: 3)).then(
      (_) async {
        try {
          final response = await http.get(Uri.parse(url), headers: headers);

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            finishedMatchList.value = data['data'];
            // finishedMatchList
            //     .sort((a, b) => b["startDate"].compareTo(a["startDate"]));

            finishedListStatus.value = 'Success';
          } else {
            log('getFinishedMatchList Response Error: ${response.statusCode}');
            finishedListStatus.value = 'Error';
          }
        } catch (e) {
          log("getFinishedMatchList Error $e");
          finishedListStatus.value = 'Error';
        }
      },
    );
  }

  Future<void> getFeaturedMatchList() async {
    featuredListStatus.value = 'Loading';

    var startDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().subtract(const Duration(days: 1)))
        .toString();
    var endDate = DateFormat('yyyy-MM-dd')
        .format(
          DateTime.now().add(
            const Duration(days: 3),
          ),
        )
        .toString();

    String url =
        'https://cricket.sportmonks.com/api/v2.0/fixtures?api_token=oIa1RHGHYILtHo45I6YTH7CTqHGfywRDfaZJHeGFtynIucVzfzSMXR0OlrQU&include=localTeam,visitorTeam,league,venue,tosswon,&filter[starts_between]=$startDate,$endDate';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        featuredMatchList.value = data['data'];
        featuredListStatus.value = 'Success';
      } else {
        log('getFeaturedMatchList Response Error: ${response.statusCode}');
        featuredListStatus.value = 'Error';
      }
    } catch (e) {
      log("getFeaturedMatchList Error $e");
      featuredListStatus.value = 'Error';
    }
  }

  Future<void> getSeriesResultList(int seriesID) async {
    seriesResultStatus.value = 'Loading';

    String url =
        'https://cricket-live-line1.p.rapidapi.com/series/$seriesID/recentMatches';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        seriesResultList.value = data['data'];

        seriesResultStatus.value = 'Success';
      } else {
        log('getSeriesMatchList Response Error: ${response.statusCode}');
        seriesResultStatus.value = 'Error';
      }
    } catch (e) {
      log("getSeriesMatchList Error $e");
      seriesResultStatus.value = 'Error';
    }
  }
}
