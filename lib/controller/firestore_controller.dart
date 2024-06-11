import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:stemmchat/model/stemm_user.dart';

class FireStoreController extends GetxController {
  FirebaseFirestore fsInstance = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Rx<List<STEMMUser>> users = Rx<List<STEMMUser>>([]);

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  getUsers() {
    if (user != null) {
      try {
        fsInstance.collection("Users").snapshots().listen((event) {
          users.value = event.docs
              .map((e) => STEMMUser.fromMap(e.data()))
              .toList()
              .where((element) => element.uid != user?.uid)
              .toList();
        });
      } catch (e) {
        GetUtils.printFunction(e.toString(), "FireStoreController", "getUsers");
      }
    }
  }

  Future<void> createUserOnFireStore(STEMMUser user) async {
    await fsInstance.collection("Users").add(user.toMap());
  }
}
