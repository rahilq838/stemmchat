import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  Stream <User?> get user => FirebaseAuth.instance.authStateChanges();

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user;
    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong
      return null;
    }

  }

  // Implement other authentication methods (e.g., Google Sign-In)

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    }
    catch (error) {
      // TODO: Implement error alert dialog if something goes wrong
    }
  }
}
