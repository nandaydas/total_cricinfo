import 'package:get/get.dart';
import 'package:total_cricinfo/routes/route_names.dart';
import 'package:total_cricinfo/view/News/news_view_page.dart';
import 'package:total_cricinfo/view/home/home_page.dart';
import 'package:total_cricinfo/view/match/match_view_page.dart';
import 'package:total_cricinfo/view/others/team_ranking.dart';
import 'package:total_cricinfo/view/player/player_info_page.dart';
import 'package:total_cricinfo/view/others/player_ranking.dart';
import 'package:total_cricinfo/view/series/series_view_page.dart';
import 'package:total_cricinfo/view/splash_screen.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteNames.splashScreen,
          page: () => SplashScreen(),
        ),
        GetPage(
          name: RouteNames.homeScreen,
          page: () => HomePage(),
        ),
        GetPage(
          name: RouteNames.matchView,
          page: () => MatchViewPage(),
        ),
        GetPage(
          name: RouteNames.seriesView,
          page: () => SeriesViewPage(),
        ),
        GetPage(
          name: RouteNames.newsView,
          page: () => NewsViewPage(),
        ),
        GetPage(
          name: RouteNames.playerInfo,
          page: () => PlayerInfoPage(
            playerId: Get.arguments,
          ),
        ),
        GetPage(
          name: RouteNames.playerRanking,
          page: () => PlayerRanking(),
        ),
        GetPage(
          name: RouteNames.teamRanking,
          page: () => TeamRanking(),
        ),
      ];
}
