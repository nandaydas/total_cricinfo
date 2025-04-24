import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class AdController extends GetxController {
  Rx<BannerAd?> bannerAd = Rx<BannerAd?>(null);
  Rx<InterstitialAd?> interstitialAd = Rx<InterstitialAd?>(null);
  RxInt navigationCount = 0.obs; // Counter for navigation events

  @override
  void onInit() {
    super.onInit();
    loadInterstitialAd();
  }

  void loadBannerAd() {
    // Dispose of any existing ad before creating a new one
    bannerAd.value?.dispose();

    bannerAd.value = BannerAd(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/6300978111' // Test Ad Unit
          : Platform.isAndroid
              ? 'ca-app-pub-8683407615272230/6361372135'
              : 'ca-app-pub-8683407615272230/9032678600',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd.value = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          bannerAd.value = null;
          log('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  // 🔹 Load Interstitial Ad
  void loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: kDebugMode
          ? 'ca-app-pub-3940256099942544/1033173712' // Test Interstitial Ad Unit
          : Platform.isAndroid
              ? 'ca-app-pub-8683407615272230/2794528188'
              : 'ca-app-pub-8683407615272230/4282064744',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd.value = ad;
        },
        onAdFailedToLoad: (error) {
          interstitialAd.value = null;
        },
      ),
    );
  }

  // 🔹 Show Interstitial Ad & Reset Counter
  void showInterstitialAd() {
    if (interstitialAd.value != null) {
      interstitialAd.value!.show();
      interstitialAd.value = null; // Reset ad after showing
      loadInterstitialAd(); // Load next interstitial ad
    }
  }

  // 🔹 Track Navigation & Show Ad When Needed
  void incrementNavigationCount() {
    navigationCount.value++; // Increase counter
    log(navigationCount.value.toString());

    if (navigationCount.value >= 4) {
      showInterstitialAd();
      navigationCount.value = 0; // Reset counter after showing ad
    }
  }

  @override
  void onClose() {
    bannerAd.value?.dispose();
    interstitialAd.value?.dispose();
    super.onClose();
  }
}
