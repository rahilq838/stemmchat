import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stemmchat/controller/firestore_controller.dart';

import '../model/stemm_user.dart';

class AuthController extends GetxController {
  @override
  void onInit() async{
    user.value = firebaseUser == null
        ? null
        : STEMMUser(uid: firebaseUser!.uid, email: firebaseUser!.email!);

    if(firebaseUser != null){
      final data = await fireStoreController.fsInstance
          .collection("Users")
          .doc(firebaseUser!.uid)
          .get();
      user.value  = STEMMUser.fromMap(data.data()!);
    }


    super.onInit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? firebaseUser = FirebaseAuth.instance.currentUser;
  Stream<User?> get userStream => _auth.authStateChanges();
  Rx<STEMMUser?> user = Rx<STEMMUser?>(null);
  FireStoreController fireStoreController = Get.find<FireStoreController>();

  //Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final data  = await fireStoreController.fsInstance
          .collection("Users")
          .doc(credential.user?.uid)
          .get();

      user.value  = STEMMUser.fromMap( data.data()!);
      GetUtils.printFunction("user", user.toString(), "d");


      // user =
      //     STEMMUser(uid: credential.user!.uid, email: credential.user!.email!,profileUrl: );

      return credential.user;
    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong

      Get.defaultDialog(
          title: "Error",
          middleText:
              error.toString());

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
      user.value  =
          STEMMUser(uid: credential.user!.uid, email: credential.user!.email!,profileUrl: null);
      await fireStoreController.createUserOnFireStore(user.value !);

      return credential.user;
    } catch (error) {
        Get.defaultDialog(
    title: "Error",
    middleText:
    error.toString());
        return null;
    }
  }

  //Sign out
  Future<void> signOut() async {
    try {
      user.value  = null;
      await _auth.signOut();
    } catch (error) {
      // TODO: Implement error alert dialog if something goes wrong
    }
  }
}
