import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/chat_user.dart';
import '../model/stemm_user.dart';
import 'auth_controller.dart';
import 'firestore_controller.dart';

class HomeController extends GetxController {
  final fireStoreController = Get.find<FireStoreController>();
  final authController = Get.find<AuthController>();
  FirebaseFirestore fsInstance = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  Rx<List<STEMMUser>> users = Rx<List<STEMMUser>>([]);
  Rx<UploadTask?> uploadTask = Rx<UploadTask?>(null);

  @override
  void onInit() async {
    GetUtils.printFunction("HomeController", "onInit", "onInit");
    await getUsers();
    super.onInit();
  }

  getUsers() async {
    if (user != null) {
      try {
        GetUtils.printFunction("getUsers", "HomeController", "getUsers");
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

  uploadProfilePic(PlatformFile file) async{
    try{
      uploadTask.value = FirebaseStorage.instance
          .ref(
              '${authController.user.value ?.uid}/${authController.user.value ?.uid}.${file.extension}')
          .putData(file.bytes!);

      GetUtils.printFunction("uploadProfilePic", "FireBaseStorageController", "uploadProfilePic");
      await uploadTask.value!.whenComplete(() async {
        String downloadUrl =
            await uploadTask.value!.snapshot.ref.getDownloadURL();
        GetUtils.printFunction("downloadUrl",downloadUrl, "${user?.uid}");
        final ref = fsInstance
            .collection("Users").doc(user?.uid).update({
          "profileUrl": downloadUrl});
        authController.user.value !.profileUrl = downloadUrl;
        Get.back();
        Get.defaultDialog(title: "Success", middleText: "Profile Picture Updated");

      });
    }catch(e){

      GetUtils.printFunction(
          e.toString(), "FireBaseStorageController", "uploadProfilePicERROR",
          isError: true);
    }
  }

  prepareUploadOfProfilePic() async {

    try {
      GetUtils.printFunction(
          "uploadProfilePic", "FireBaseStorageController", "uploadProfilePic");

      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
          withData: true
      );

      if (result != null) {
        PlatformFile file = result.files.first;
        Get.defaultDialog(title: "Upload", content: Text(file.name),actions: [
          ElevatedButton(onPressed: (){
            Get.back();
          }, child: const Text("Cancel")),
          ElevatedButton(onPressed: () async{
              await uploadProfilePic(file);

          }, child: const Text("Upload"))
        ]);
      } else {
        Get.defaultDialog(
            title: "No Image Was Selected", middleText: "Please Try Again");
      }

      // Get.defaultDialog(title: "Upload", content: )
    } catch (e) {
      GetUtils.printFunction(
          e.toString(), "FireBaseStorageController", "uploadProfilePic",
          isError: true);
    }
  }

}
