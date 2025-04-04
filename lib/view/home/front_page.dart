import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/home_controller.dart';
import 'package:total_cricinfo/controllers/match_list_controller.dart';
import 'package:total_cricinfo/controllers/news_controller.dart';
import 'package:total_cricinfo/controllers/series_controller.dart';
import 'package:total_cricinfo/routes/route_names.dart';
import 'package:total_cricinfo/view/widgets/my_drawer.dart';
import '../../controllers/ad_controller.dart';
import '../widgets/match_card_horiz.dart';

class FrontPage extends StatelessWidget {
  FrontPage({super.key});

  final MatchListController mlc = Get.put(MatchListController());
  final NewsController nc = Get.put(NewsController());
  final HomeController hc = Get.put(HomeController());
  final SeriesController sc = Get.put(SeriesController());
  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      adController.loadBannerAd();
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Total CricInfo',
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lato'),
        ),
        leading: Center(
          child: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              borderRadius: BorderRadius.circular(100),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.all(2),
                    child: const SizedBox(
                      height: 20,
                      child: Icon(Icons.person_rounded, size: 20),
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      padding: const EdgeInsets.all(1),
                      child: const Icon(
                        Icons.menu_rounded,
                        color: Colors.black,
                        size: 12,
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        actions: [
          Center(
            child: InkWell(
              onTap: () {
                Fluttertoast.showToast(msg: "Coming soon!");
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  "images/wallet.png",
                  height: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 6)
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 84,
                      width: double.infinity,
                      color: primaryColor,
                    )
                  ],
                ),
                Obx(
                  () => mlc.featuredListStatus.value == 'Loading'
                      ? Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : mlc.featuredListStatus.value == 'Error'
                          ? const Center(
                              child: Text('Something went wrong'),
                            )
                          : mlc.featuredMatchList.isEmpty
                              ? const Center(
                                  child: Text('No matches found'),
                                )
                              : SizedBox(
                                  height: 160,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6.0),
                                    itemCount: mlc.featuredMatchList.length,
                                    itemBuilder: (context, index) {
                                      final matchData =
                                          mlc.featuredMatchList[index];
                                      return MatchCardHoriz(
                                        matchData: matchData,
                                      );
                                    },
                                  ),
                                ),
                ),
              ],
            ),
            Obx(
              () {
                final banner = adController.bannerAd.value;
                if (banner != null) {
                  return SizedBox(
                    height: banner.size.height.toDouble(),
                    width: double.infinity,
                    child: AdWidget(ad: banner),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            _seriesMatches(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Stories',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      hc.selectedIndex.value = 3;
                    },
                    child: Text(
                      'View all',
                      style: TextStyle(
                        fontSize: 14,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => nc.newsStatus.value == 'Loading'
                  ? Center(
                      child: Lottie.asset(
                        'images/loading.json',
                        height: 200,
                        width: 200,
                      ),
                    )
                  : nc.newsStatus.value == 'Error'
                      ? const Center(
                          child: Text('Something went wrong'),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  newsCard(context, nc.newsList[0]),
                                  newsCard(context, nc.newsList[1]),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  newsCard(context, nc.newsList[2]),
                                  newsCard(context, nc.newsList[3]),
                                ],
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    RouteNames.newsView,
                                    arguments: nc.newsList[4],
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Stack(
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: CachedNetworkImage(
                                          imageUrl: nc.newsList[4]['image'],
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      AspectRatio(
                                        aspectRatio: 16 / 9,
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Colors.black.withOpacity(0.9),
                                              ],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: Container(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  nc.newsList[4]['title'],
                                                  maxLines: 3,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white),
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      nc.newsList[4]
                                                          ['pub_date'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: primaryColor.withOpacity(0.5),
                                          width: 0.2),
                                    ),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          RouteNames.newsView,
                                          arguments: nc.newsSubList[index],
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    nc.newsSubList[index]
                                                        ['title'],
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(height: 4),
                                                  Text(
                                                    nc.newsSubList[index]
                                                        ['pub_date'],
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors
                                                            .grey.shade600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                              topRight: Radius.circular(12),
                                              bottomRight: Radius.circular(12),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: nc.newsSubList[index]
                                                  ['image'],
                                              height: 80,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget newsCard(BuildContext context, Map news) {
    return SizedBox(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.45,
      child: InkWell(
        onTap: () {
          Get.toNamed(
            RouteNames.newsView,
            arguments: news,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: news['image'],
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.9),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      news['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _seriesMatches() {
    return Obx(
      () {
        if (sc.seriesListStatus.value == 'Loading') {
          return const SizedBox();
        } else if (sc.seriesListStatus.value == 'Error') {
          return const SizedBox();
        } else {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${sc.seriesList[0]['series']}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () {
                        hc.selectedIndex.value = 2;
                      },
                      child: Text(
                        'View all',
                        style: TextStyle(
                          fontSize: 14,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => sc.seriesUpcomingStatus.value == 'Loading'
                    ? Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : sc.seriesUpcomingStatus.value == 'Error'
                        ? const Center(
                            child: Text('Something went wrong'),
                          )
                        : sc.seriesUpcomingList.isEmpty
                            ? const Center(
                                child: Text('No matches found'),
                              )
                            : SizedBox(
                                height: 160,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  itemCount: sc.seriesUpcomingList.length,
                                  itemBuilder: (context, index) {
                                    final matchData =
                                        sc.seriesUpcomingList[index];
                                    return MatchCardHoriz(
                                      matchData: matchData,
                                    );
                                  },
                                ),
                              ),
              ),
            ],
          );
        }
      },
    );
  }
}
