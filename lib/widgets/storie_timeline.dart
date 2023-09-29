// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class StorieTimeline extends StatefulWidget {
  const StorieTimeline({
    super.key,
  });

  @override
  State<StorieTimeline> createState() => _StorieTimelineState();
}

class _StorieTimelineState extends State<StorieTimeline> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      // padding: EdgeInsets.only(left: 15),
      // color: Colors.blue,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage("assets/images/hugues.png"),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage("assets/images/lait.jpg"),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage("assets/images/pexels-cal.jpg"),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage("assets/images/profile_image.jpg"),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage("assets/images/cafe.jpg"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
