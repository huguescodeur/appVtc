// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home/addpost_screen.dart';
import '../screens/home/notification_screen.dart';
import '../screens/home/profile_screen.dart';
import '../screens/home/search_screen.dart';
import '../screens/home/timeline_screen.dart';

import '../utils/colors.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({Key? key}) : super(key: key);

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  late PageController pageController;
  var focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  // * Type index
  int selectedPage = 0;

  void onTappedBar(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  // focusNode.hasFocus?null :
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: mobileBackgroundColor,
            selectedItemColor: primaryColor,
            unselectedItemColor: secondaryColor,
            currentIndex: selectedPage,
            onTap: onTappedBar,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.camera_alt,
                  size: 36,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "",
              ),
            ]),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            onPageChanged(index);
          },
          children: const [
            SearchScreen(),
            TimelineScreen(),
            AddpostScreen(),
            NotificationScreen(),
            ProfileScreen(),
          ],
        ));
  }
}
