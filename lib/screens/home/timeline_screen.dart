// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../utils/colors.dart';
import '../../widgets/header_timeline.dart';
import '../../widgets/storie_timeline.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green.shade400,
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: const Column(
              children: <Widget>[HeaderTimeline(), Gap(15), StorieTimeline()],
            ),
          ),
        ));
  }
}
