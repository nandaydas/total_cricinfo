import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/series_controller.dart';
import 'package:total_cricinfo/view/widgets/series_card.dart';
import '../../controllers/home_controller.dart';

class SeriesPage extends StatelessWidget {
  SeriesPage({super.key});

  final SeriesController sc = Get.put(SeriesController());
  final HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Series'),
        leading: IconButton(
          onPressed: () {
            hc.selectedIndex.value = 0;
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Obx(
        () => sc.seriesListStatus.value == 'Loading'
            ? Center(
                child: Lottie.asset(
                  'images/loading.json',
                  height: 200,
                  width: 200,
                ),
              )
            : sc.seriesListStatus.value == 'Error'
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Something went wrong'),
                        const SizedBox(height: 4),
                        OutlinedButton(
                          onPressed: () {
                            sc.getSeriesList();
                          },
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  )
                : sc.seriesList.isEmpty
                    ? const Center(
                        child: Text('No series found'),
                      )
                    : Scrollbar(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          itemCount: sc.seriesList.length,
                          itemBuilder: (context, index) {
                            final seriesData = sc.seriesList[index];
                            return SeriesCard(
                              seriesData: seriesData,
                            );
                          },
                        ),
                      ),
      ),
    );
  }
}
