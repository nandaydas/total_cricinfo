import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/series_controller.dart';
import 'package:total_cricinfo/view/widgets/news_card.dart';

class SeriesNewsTab extends StatelessWidget {
  SeriesNewsTab({super.key});
  final SeriesController sc = Get.put(SeriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => sc.seriesNewsStatus.value == 'Loading'
            ? Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              )
            : sc.seriesNewsStatus.value == 'Error'
                ? const Center(
                    child: Text('Something went wrong'),
                  )
                : ListView.builder(
                    itemCount: sc.seriesNewsList.length,
                    itemBuilder: (context, index) {
                      var news = sc.seriesNewsList[index];
                      return NewsCard(news: news);
                    },
                  ),
      ),
    );
  }
}
