// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driver_app/services/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthServices {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final currentUser = FirebaseAuth.instance.currentUser!;

  // ? Message toast
  messageToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
    );
  }

  // ? Login method
  login({
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      messageToast(
          message: "Email valide & password valide: Vous êtes connecté !!!");
    } on FirebaseAuthException catch (e) {
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

  // ? Register
  register(
      {required String nameController,
      required String emailController,
      required int phoneController,
      required String passwordController}) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: emailController,
        password: passwordController,
      );
      final userModel = UserModel(
          name: nameController, email: emailController, phone: phoneController);
      await db
          .collection("Users")
          .doc(userCredential.user!.uid)
          .set(userModel.toFirestore());
      messageToast(message: "Inscription réussie");
    } on FirebaseAuthException catch (e) {
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
}
