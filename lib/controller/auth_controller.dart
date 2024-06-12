import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/controller/firestore_controller.dart';

import '../model/stemm_user.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    user = firebaseUser == null
        ? null
        : STEMMUser(uid: firebaseUser!.uid, email: firebaseUser!.email!);
    super.onInit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  Stream<User?> get userStream => _auth.authStateChanges();
  STEMMUser? user;
  FireStoreController fireStoreController = Get.find<FireStoreController>();

  //Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user =
          STEMMUser(uid: credential.user!.uid, email: credential.user!.email!);

      return credential.user;
    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong

      Get.defaultDialog(
          title: "Error",
          middleText:
              "This might occur because of\nWrong Email\n Wrong Password\nUser Does Not Exist");

      return null;
    }
    return null;
  }

  //Register with email and password
  Future<User?> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user =
          STEMMUser(uid: credential.user!.uid, email: credential.user!.email!);
      await fireStoreController.createUserOnFireStore(user!);
      return credential.user;
    } catch (error) {
        Get.defaultDialog(
    title: "Error",
    middleText:
    "This might occur because of\nWrong Email\n Wrong Password\nUser Does Not Exist");
        return null;
    }
  }

  //Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong
    }
  }
}
