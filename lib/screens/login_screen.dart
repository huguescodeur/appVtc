// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:driver_app/screens/home_screen.dart';
import 'package:driver_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/colors.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_social_button.dart';
import '../widgets/widget_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String idScreen = "login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoadingProcess = false;
  bool dialogLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // * Login
  login() async {
    try {
      setState(() {
        isLoadingProcess = true;
      });

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text)
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.idScreen, (route) => false));

      messageToast(
          message: "Email valide & password valide: Vous êtes connecté !!!");
      setState(() {
        isLoadingProcess = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoadingProcess = false;
      });
      if (e.code == 'user-not-found') {
        messageToast(message: "Aucun utilisateur trouvé pour cet e-mail.");
        print("No user found for that email");
      } else if (e.code == 'wrong-password') {
        messageToast(
            message: "Mauvais mot de passe fourni pour cet utilisateur.");
        print('Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  // * Google login
  /*Future<UserCredential>*/
  signInWithGoogle() async {
    // Trigger the authentication flow

    /*setState(() {
        dialogLoading = true;
      });*/
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    /* setState(() {
        dialogLoading = false;
      });*/
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) => Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.idScreen, (route) => false));
  }

  // ? Message toast
  messageToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  @override
  Widget build(BuildContext context) {
    /* SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));*/
    return Scaffold(
      backgroundColor: mobileBackgroundColor /*Colors.yellow.withOpacity(0.9)*/,
      body: SafeArea(
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            // padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Gap(120),
                  const Icon(
                    Icons.drive_eta,
                    size: 150,
                    color: Colors.white,
                  ),
                  const Gap(10),
                  WidgetTextField(
                      obscureText: false,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      hintText: "Email"),
                  const Gap(20),
                  WidgetTextField(
                      obscureText: true,
                      controller: passwordController,
                      type: TextInputType.text,
                      hintText: "Mot de passe"),
                  const Gap(
                    20,
                  ),
                  WidgetButton(
                    onPressed: () async {
                      if (emailController.text.isEmpty) {
                        messageToast(message: "Veuillez entrer votre email");
                      } else if (passwordController.text.isEmpty) {
                        messageToast(
                            message: "Veuillez entrer votre mot de passe");
                      } else {
                        await login();
                      }
                    },
                    text: "Connexion",
                    isLoadingProcess: isLoadingProcess,
                  ),
                  const Gap(
                    10,
                  ),
                  const Text(
                    "Ou",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Connectez-vous avec",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      WidgetSocialButton(
                          onTap: () async {
                            await signInWithGoogle();
                          },
                          image: "assets/images/google_1.png"),
                      const Gap(10),
                      const Text("Ou",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const Gap(10),
                      WidgetSocialButton(
                        onTap: () {},
                        image: "assets/images/facebook.png",
                      ),
                    ],
                  ),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Vous n'avez pas un compte? "),
                      InkWell(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context,
                              RegisterScreen.idScreen,
                              (route) => false),
                          child: const Text(
                            "Créer un compte",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

/* dialogLoading? showDialog(context: context, builder: (context) =>
                            const AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.amberAccent,),
                              ),

                            ),) : Container();*/
