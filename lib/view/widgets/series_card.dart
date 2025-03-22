import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/routes/route_names.dart';
import '../../controllers/ad_controller.dart';

class SeriesCard extends StatelessWidget {
  SeriesCard({super.key, required this.seriesData});

  final Map seriesData;
  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black.withOpacity(0.2), width: 0.2),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: InkWell(
        onTap: () {
          adController.incrementNavigationCount();
          Get.toNamed(RouteNames.seriesView, arguments: seriesData);
        },
        borderRadius: BorderRadius.circular(10.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              child: CachedNetworkImage(
                imageUrl: seriesData['image'],
                height: 64,
                width: 64,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) =>
                    ColoredBox(color: Colors.grey.shade300),
                placeholder: (context, url) =>
                    ColoredBox(color: Colors.grey.shade300),
              ),
            ),
            Expanded(
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                title: Text(
                  "${seriesData['series']}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16),
                ),
                subtitle: Text(
                  "${seriesData['series_date']}",
                  style: TextStyle(
                      fontSize: 14, color: primaryColor.withOpacity(0.8)),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
