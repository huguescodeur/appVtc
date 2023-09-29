// ignore_for_file: sized_box_for_whitespace, avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../widgets/user_image_and_back_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  static const String idScreen = "profile";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // var sizeWidth = double.infinity / 2;
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Container(
        width: double.infinity,
        child: const Column(
          children: <Widget>[
            UserImageAndBackroundProfile(),
            Text("Goli Yao Hugues"),
            ListTile(
              leading: Icon(Icons.wifi),
              title: Text("www.google.fr"),
            )
          ],
        ),
      ),
    );
  }
}
