import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constants/colors.dart';

class ExpertPicksTab extends StatelessWidget {
  ExpertPicksTab({super.key, required this.matchId});

  final String matchId;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirestoreListView(
        query: _firestore
            .collection("Predictions")
            .where("match_id", isEqualTo: matchId)
            .orderBy("time", descending: true),
        padding: const EdgeInsets.symmetric(vertical: 6),
        emptyBuilder: (context) => const Center(
          child: Text("No picks available"),
        ),
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Text("Something went wrong"),
        ),
        itemBuilder: (context, doc) {
          var item = doc.data();

          final RxString userName = "".obs;
          final RxString userImage = "".obs;

          _firestore.collection("Users").doc(item['user_id']).get().then(
            (snapshot) {
              userImage.value = snapshot.data()!['image'];
              userName.value = snapshot.data()!['name'];
            },
          );

          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: primaryColor.withOpacity(0.5), width: 0.2),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Obx(
                  () => CachedNetworkImage(
                    imageUrl: userImage.value,
                    height: 50,
                    width: 50,
                    errorWidget: (context, url, error) =>
                        const ColoredBox(color: Colors.grey),
                    placeholder: (context, url) =>
                        const ColoredBox(color: Colors.grey),
                  ),
                ),
              ),
              title: Obx(
                () => Text(userName.value),
              ),
              subtitle: Text(readTimestamp(item['time'].seconds)),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Predicted Result",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    item['match'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} Day ago';
      } else {
        time = '${diff.inDays} Days ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} Week ago';
      } else {
        time = '${(diff.inDays / 7).floor()} Weeks ago';
      }
    }

    return time;
  }
}
