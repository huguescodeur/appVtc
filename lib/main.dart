import 'package:driver_app/screens/home_screen.dart';
import 'package:driver_app/services/auth/logged_or_not.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          LoginScreen.idScreen: (context) => const LoginScreen(),
          RegisterScreen.idScreen: (context) => const RegisterScreen(),
          HomeScreen.idScreen: (context) => const HomeScreen(),
          LoggedOrNot.idScreen: (context) => const LoggedOrNot()
        },
        initialRoute: LoggedOrNot.idScreen);
  }
}
