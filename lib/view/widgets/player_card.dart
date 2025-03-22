import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:total_cricinfo/constants/colors.dart';
import 'package:total_cricinfo/controllers/player_info_controller.dart';
import 'package:total_cricinfo/routes/route_names.dart';

import '../../controllers/ad_controller.dart';

class PlayerCard extends StatelessWidget {
  PlayerCard(
      {super.key,
      required this.player,
      required this.margin,
      required this.color});

  final Map player;
  final EdgeInsetsGeometry margin;
  final Color color;
  final PlayerInfoController pic = Get.put(PlayerInfoController());
  final AdController adController = Get.put(AdController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.5), width: 0.2),
      ),
      margin: margin,
      child: InkWell(
        onTap: () {
          adController.incrementNavigationCount();
          pic.playerInfo.value = {
            'player': {
              'name': player['name'],
              'image': player['image'],
            }
          };
          Get.toNamed(RouteNames.playerInfo,
              arguments: player['player_id'].toString());
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: player['image'],
                  height: 34,
                  width: 34,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      ColoredBox(color: Colors.grey.shade300),
                  errorWidget: (context, url, error) =>
                      ColoredBox(color: Colors.grey.shade300),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                title: Text(player['name']),
                subtitle: Text(player['play_role']),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
