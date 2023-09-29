import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HeaderTimeline extends StatefulWidget {
  const HeaderTimeline({Key? key}) : super(key: key);

  @override
  State<HeaderTimeline> createState() => _HeaderTimelineState();
}

class _HeaderTimelineState extends State<HeaderTimeline> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        // color: Colors.blue,
        child: Row(
          children: <Widget>[
            const Text(
              "My Driver",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white.withOpacity(0.3),
              ),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  )),
            ),
            const Gap(12),
            const CircleAvatar(
              radius: 27,
              backgroundImage: AssetImage("assets/images/christ.jpg"),
            )
          ],
        ));
  }
}
