import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:total_cricinfo/constants/colors.dart';
import '../../controllers/ad_controller.dart';

class NewsViewPage extends StatelessWidget {
  NewsViewPage({super.key});

  final Map newsData = Get.arguments;
  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      adController.loadBannerAd();
    });
    return Scaffold(
      bottomNavigationBar: Obx(() {
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
      }),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            elevation: 0,
            expandedHeight: 200,
            title: Text(
              "${newsData['title']}",
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: "${newsData['image']}",
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${newsData['title']}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        "${newsData['pub_date'] ?? newsData['date']}",
                        style: TextStyle(fontSize: 12, color: primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  HtmlWidget(
                      "${newsData['content'] is List ? newsData['content'][0] : newsData['content']}"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
