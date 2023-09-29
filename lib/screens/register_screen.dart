// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/screens/home_screen.dart';
import 'package:driver_app/screens/login_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../services/models/user_model.dart';
import '../utils/colors.dart';
import '../widgets/widget_button.dart';
import '../widgets/widget_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String idScreen = "register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool isValid = false;
  bool isLoadingProcess = false;

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  // ? Register
  register() async {
    try {
      setState(() {
        isLoadingProcess = true;
      });

      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      final userModel = UserModel(
          name: nameController.text,
          email: emailController.text,
          phone: int.parse(phoneController.text));
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set(userModel.toFirestore());

      setState(() {
        isLoadingProcess = false;
      });
      messageToast(message: "Inscription réussie");
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoadingProcess = false;
      });
      if (e.code == 'weak-password') {
        messageToast(message: "Faible mot de passe.");
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        messageToast(message: "Email déjà utilisé.");
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // ? Message toast
  messageToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  @override
  Widget build(BuildContext context) {
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
                  const Gap(50),
                  const Icon(
                    Icons.drive_eta,
                    size: 150,
                    color: Colors.white,
                  ),
                  const Gap(10),
                  WidgetTextField(
                      obscureText: false,
                      controller: nameController,
                      type: TextInputType.name,
                      hintText: "Nom"),
                  const Gap(20),
                  WidgetTextField(
                      obscureText: false,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      hintText: "Email"),
                  const Gap(20),
                  WidgetTextField(
                      obscureText: false,
                      controller: phoneController,
                      type: TextInputType.phone,
                      hintText: "Numéro de téléphone"),
                  const Gap(20),
                  WidgetTextField(
                      obscureText: true,
                      controller: passwordController,
                      type: TextInputType.text,
                      hintText: "Mot de passe"),
                  const Gap(20),
                  WidgetTextField(
                      obscureText: true,
                      controller: confirmController,
                      type: TextInputType.text,
                      hintText: "Confirmer votre mot de passe"),
                  const Gap(
                    20,
                  ),
                  WidgetButton(
                    onPressed: () async {
                      isValid = EmailValidator.validate(emailController.text);
                      var phoneRegex = RegExp(
                          r"^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$");
                      if (nameController.text.isEmpty) {
                        messageToast(message: "Veuillez entrer votre nom");
                      } else if (nameController.text.length < 4) {
                        messageToast(
                            message:
                                "Le nom doit être supérieur à 3 caractères.");
                      } else if (emailController.text.isEmpty) {
                        messageToast(message: "Veuillez entrer votre email");
                      } else if (!isValid) {
                        messageToast(message: "Entrer une email valide");
                      } else if (phoneController.text.isEmpty) {
                        messageToast(
                            message:
                                "Veuillez entrer votre numéro de téléphone");
                      } else if (!phoneRegex.hasMatch(phoneController.text)) {
                        messageToast(
                            message: "Entrer un un numéro de téléphone valide");
                      } else if (passwordController.text.isEmpty) {
                        messageToast(
                            message: "Veuillez entrer votre mot de passe");
                      } else if (confirmController.text.isEmpty) {
                        messageToast(
                            message: "Veuillez confirmer votre mot de passe");
                      } else if (confirmController.text !=
                          passwordController.text) {
                        messageToast(
                            message: "Les mots de passe ne correspondent pas");
                      } else if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          phoneRegex.hasMatch(phoneController.text)) {
                        await register();
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeScreen.idScreen, (route) => false);
                      } else {
                        messageToast(message: "Entrer un email valid");
                        print("Echec de la connexion !");
                      }
                    },
                    text: "Inscription",
                    isLoadingProcess: isLoadingProcess,
                  ),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Vous avez un compte? "),
                      InkWell(
                          onTap: () => Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.idScreen, (route) => false),
                          child: const Text(
                            "Connectez-vous",
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
