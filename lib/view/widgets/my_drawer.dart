import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/constants/links.dart';
import 'package:total_cricinfo/routes/route_names.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/ad_controller.dart';
// import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({super.key});

  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    primaryColor,
                    Colors.green.shade800,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Total CricInfo',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.white),
                    ),
                    Text(
                      'Blizzing Cricket Updates',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    )
                  ],
                ),
              ),
            ),
            draItem(
              'Home',
              Icons.home_outlined,
              () {
                Navigator.pop(context);
              },
            ),
            draItem(
              'Player Ranking',
              Icons.group_outlined,
              () {
                adController.incrementNavigationCount();
                Get.toNamed(RouteNames.playerRanking);
              },
            ),
            draItem(
              'Team Ranking',
              Icons.flag_outlined,
              () {
                adController.incrementNavigationCount();
                Get.toNamed(RouteNames.teamRanking);
              },
            ),

            // const Divider(),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Column(
            //     children: [
            //       const Row(
            //         children: [
            //           Text(
            //             'Connect with us',
            //             style: TextStyle(fontWeight: FontWeight.w600),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(height: 16),
            //       Row(
            //         children: [
            //           InkWell(
            //             onTap: () async {
            //               final url = Uri.parse(
            //                   'https://www.instagram.com/sixcricofficial/');
            //               if (await canLaunchUrl(url)) {
            //                 await launchUrl(url);
            //               }
            //             },
            //             child: Image.asset(
            //               'images/instagram.png',
            //               height: 32,
            //               width: 36,
            //             ),
            //           ),
            //           const SizedBox(width: 20),
            //           InkWell(
            //             onTap: () async {
            //               final url = Uri.parse('https://x.com/6cric');
            //               if (await canLaunchUrl(url)) {
            //                 await launchUrl(url);
            //               }
            //             },
            //             child: Image.asset(
            //               'images/twitter.png',
            //               height: 28,
            //               width: 36,
            //             ),
            //           ),
            //           const SizedBox(width: 20),
            //           InkWell(
            //             onTap: () async {
            //               final url =
            //                   Uri.parse('https://www.youtube.com/@Sixcric');
            //               if (await canLaunchUrl(url)) {
            //                 await launchUrl(url);
            //               }
            //             },
            //             child: Image.asset(
            //               'images/youtube.png',
            //               height: 36,
            //               width: 36,
            //             ),
            //           ),
            //           const SizedBox(width: 20),
            //           InkWell(
            //             onTap: () async {
            //               final url =
            //                   Uri.parse('mailto:ukmsoftware1@gmail.com');
            //               if (await canLaunchUrl(url)) {
            //                 await launchUrl(url);
            //               }
            //             },
            //             child: Image.asset(
            //               'images/communication.png',
            //               height: 36,
            //               width: 36,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // draItem(
            //   'Connect with us',
            //   Icons.mail_outline,
            //   () async {
            //     final url = Uri.parse('mailto:');
            //     if (await canLaunchUrl(url)) {
            //       await launchUrl(url);
            //     }
            //   },
            // ),
            const Divider(),
            draItem(
              'Rate us',
              Icons.star_outline,
              () async {
                final url = Uri.parse(appLink);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            draItem(
              'Share this app',
              Icons.share_outlined,
              () {
                Share.share(
                    "https://play.google.com/store/apps/dev?id=5260779793985937102");
              },
            ),
            draItem(
              'Privacy Policy',
              Icons.lock_outline,
              () async {
                final url = Uri.parse(privacyPolicy);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
            draItem(
              'Terms & Conditions',
              Icons.gavel_outlined,
              () async {
                final url = Uri.parse(termsConditions);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget draItem(String title, IconData icon, Function action) {
    return InkWell(
      onTap: () => action(),
      child: ListTile(
        leading: Icon(icon),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
