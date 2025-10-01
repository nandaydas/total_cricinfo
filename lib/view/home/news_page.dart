import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/home_controller.dart';
import 'package:total_cricinfo/controllers/news_controller.dart';
import '../widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});

  // Use Get.find for controllers that should already be initialized
  final NewsController nc = Get.put(NewsController());
  final HomeController hc = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- AppBar Update ---
      appBar: AppBar(
        title: const Text(
          'Latest Cricket News',
          style: TextStyle(
            fontWeight: FontWeight.w800, // Make the title bolder
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white, // Clean white background
        elevation: 1, // Subtle shadow for depth
        leading: IconButton(
          onPressed: () {
            // Assuming index 0 is the main home screen
            hc.selectedIndex.value = 0;
            // Optionally, use Get.back() if this page was navigated to
            // Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
        ),
      ),
      
      // --- Main Body with State Management ---
      body: Obx(
        () {
          final status = nc.newsStatus.value;
          
          // --- 1. Loading State (More Engaging) ---
          if (status == 'Loading') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'images/loading.json', // Assuming a suitable loading animation
                    height: 180,
                    width: 180,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Loading headlines...',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          // --- 2. Error State (Improved Visuals) ---
          if (status == 'Error') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.signal_wifi_off_rounded, color: Colors.redAccent, size: 70),
                  const SizedBox(height: 16),
                  const Text(
                    'Network Error!',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Could not fetch news. Please try again.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => nc.getNewsList(),
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reload News'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700, // Use a distinct color for action
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ],
              ),
            );
          }

          // --- 3. Empty State (Added) ---
          if (nc.newsList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off_rounded, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No news articles found.',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'The list is currently empty.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          
          // --- 4. Success/Data Loaded State ---
          return Scrollbar(
            // Updated Scrollbar for better visibility
            thumbVisibility: true,
            thickness: 6.0,
            radius: const Radius.circular(3),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: nc.newsList.length,
              // Increased padding for better visual separation from edges
              padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              itemBuilder: (context, index) {
                // Added bottom padding to the NewsCard for spacing between items
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: NewsCard(
                    news: nc.newsList[index],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
