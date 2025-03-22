import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/home_controller.dart';
import 'package:total_cricinfo/controllers/news_controller.dart';
import '../widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  final NewsController nc = Get.put(NewsController());
  final HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        leading: IconButton(
          onPressed: () {
            hc.selectedIndex.value = 0;
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Obx(
        () => nc.newsStatus.value == 'Loading'
            ? Center(
                child: Lottie.asset(
                  'images/loading.json',
                  height: 200,
                  width: 200,
                ),
              )
            : nc.newsStatus.value == 'Error'
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Something went wrong'),
                        const SizedBox(height: 4),
                        OutlinedButton(
                          onPressed: () {
                            nc.getNewsList();
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  )
                : Scrollbar(
                    radius: const Radius.circular(16),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: nc.newsList.length,
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      itemBuilder: (context, index) {
                        return NewsCard(
                          news: nc.newsList[index],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
