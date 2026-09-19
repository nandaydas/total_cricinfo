import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:total_cricinfo/controllers/series_controller.dart';
import 'package:total_cricinfo/view/widgets/series_card.dart';
import '../../controllers/home_controller.dart';

class SeriesPage extends StatelessWidget {
  SeriesPage({super.key});

  // Ensure controllers are properly initialized and managed
  final SeriesController sc = Get.find<SeriesController>(); // Use Get.find if already put in previous binding
  final HomeController hc = Get.find<HomeController>(); // Use Get.find if already put in previous binding

  // Note: If controllers are not already initialized, use Get.put as in your original code.

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive design (if 'mq' is not available globally)
    final mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cricket Series', // More specific title
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey.shade900, // Dark, sporty background
        elevation: 0, // No shadow for a flat look
        leading: IconButton(
          onPressed: () {
            // Navigate back to the main tab (assuming index 0 is Home)
            hc.selectedIndex.value = 0;
            // Use Get.back() if this page was pushed onto the stack
            // Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
      ),
      
      // Main Body with State Management
      body: Obx(() {
        final status = sc.seriesListStatus.value;
        
        // --- 1. Loading State ---
        if (status == 'Loading') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Enhanced Lottie animation with a subtle background
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Lottie.asset(
                    'images/loading.json', // Assuming a suitable loading animation
                    height: mq.width * 0.5,
                    width: mq.width * 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Fetching the latest series...',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          );
        }
        
        // --- 2. Error State ---
        if (status == 'Error') {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline_rounded, color: Colors.red, size: 60),
                const SizedBox(height: 16),
                const Text(
                  'Failed to load data.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'Please check your internet connection.',
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => sc.getSeriesList(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey.shade800,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          );
        }

        // --- 3. Empty State ---
        if (sc.seriesList.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.inbox_outlined, size: 80, color: Colors.grey),
                const SizedBox(height: 16),
                const Text(
                  'No active series found.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Check back later for updates!',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          );
        }

        // --- 4. Success/Data Loaded State ---
        return Scrollbar(
          thumbVisibility: true, // Make the scrollbar always visible
          thickness: 6.0,
          child: ListView.builder(
            // Adding horizontal padding for better spacing around the cards
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
            itemCount: sc.seriesList.length,
            itemBuilder: (context, index) {
              final seriesData = sc.seriesList[index];
              // Assuming SeriesCard is already visually appealing, 
              // we only ensure proper padding/margin here.
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: SeriesCard(
                  seriesData: seriesData,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
