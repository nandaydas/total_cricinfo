import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/routes/route_names.dart';
import '../../constants/colors.dart';
import '../../controllers/ad_controller.dart';

class NewsCard extends StatelessWidget {
  NewsCard({super.key, required this.news});

  final Map news;

  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 4)
        // ]
        border: Border.all(color: Colors.black.withOpacity(0.2), width: 0.2),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          adController.incrementNavigationCount();
          Get.toNamed(RouteNames.newsView, arguments: news);
        },
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: CachedNetworkImage(
                      imageUrl: "${news['coverImages'] ?? news['image']}",
                      height: 60,
                      width: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          ColoredBox(color: Colors.grey.shade300),
                      errorWidget: (context, url, error) =>
                          ColoredBox(color: Colors.grey.shade300),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${news['title']}",
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          "${news['pub_date'] ?? news['date']}",
                          style: TextStyle(
                            fontSize: 12,
                            color: primaryColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                "${news['description'] ?? news['content']}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black.withOpacity(0.6),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
