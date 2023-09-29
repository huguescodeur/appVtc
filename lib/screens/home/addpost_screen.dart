import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login_screen.dart';

class AddpostScreen extends StatefulWidget {
  const AddpostScreen({Key? key}) : super(key: key);

  @override
  State<AddpostScreen> createState() => _AddpostScreenState();
}

class _AddpostScreenState extends State<AddpostScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final currentUser = FirebaseAuth.instance.currentUser;
    signOutWithGoogle() async {
      await GoogleSignIn().signOut().then((value) =>
          Navigator.pushNamedAndRemoveUntil(
              context, LoginScreen.idScreen, (route) => false));
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${currentUser?.email}"),
            IconButton(
                onPressed: () async {
                  await signOutWithGoogle();
                  await auth.signOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginScreen.idScreen, (route) => false));
                },
                icon: const Icon(Icons.logout))
          ],
        ),
      ),
    );
  }
}
